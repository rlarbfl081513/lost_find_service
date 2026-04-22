import time
import cv2
import board
import busio
from adafruit_pca9685 import PCA9685 # 모터 드라이버
from adafruit_extended_bus import ExtendedI2C as ExtI2C
from adafruit_motor import servo

# 바퀴 제어 클래스
class PWMThrottleHat:
    def __init__(self, pwm, channel):
        self.pwm = pwm
        self.channel = channel
        self.pwm.frequency = 60 # DC 모터 PWM 주파수

    def setThrottle(self, throttle):
        pulse = int(0xFFFF * abs(throttle))
        if throttle < 0:  # 전진
            self.pwm.channels[self.channel + 5].duty_cycle = pulse
            self.pwm.channels[self.channel + 4].duty_cycle = 0
            self.pwm.channels[self.channel + 3].duty_cycle = 0xFFFF
        elif throttle > 0:  # 후진
            self.pwm.channels[self.channel + 5].duty_cycle = pulse
            self.pwm.channels[self.channel + 4].duty_cycle = 0xFFFF
            self.pwm.channels[self.channel + 3].duty_cycle = 0
        else:  # 정지
            self.pwm.channels[self.channel + 5].duty_cycle = 0
            self.pwm.channels[self.channel + 4].duty_cycle = 0
            self.pwm.channels[self.channel + 3].duty_cycle = 0

# 시각화 함수
# 화면에 라인 + 화면 중심 + 조향 방향 표시
def drawDirection(frame, direction):
    SCREEN_WIDTH = frame.shape[1]
    SCREEN_HEIGHT = frame.shape[0]

    if direction == 'forward':
        text = "Direction: FORWARD"
        startArrow = (SCREEN_WIDTH // 2, SCREEN_HEIGHT - 100)
        endArrow = (SCREEN_WIDTH // 2, 100)
    elif direction == 'left':
        text = "Direction: LEFT"
        startArrow = (SCREEN_WIDTH // 2 + 100, SCREEN_HEIGHT // 2)
        endArrow = (SCREEN_WIDTH // 2 - 100, SCREEN_HEIGHT // 2)
    elif direction == 'right':
        text = "Direction: RIGHT"
        startArrow = (SCREEN_WIDTH // 2 - 100, SCREEN_HEIGHT // 2)
        endArrow = (SCREEN_WIDTH // 2 + 100, SCREEN_HEIGHT // 2)
    else:
        text = "Direction: STOP"
        startArrow = endArrow = None

    cv2.putText(frame, text, (30, 40), cv2.FONT_HERSHEY_SIMPLEX, 1.0, (0, 255, 0), 2)
    if startArrow and endArrow:
        cv2.arrowedLine(frame, startArrow, endArrow, (255, 0, 0), 5)

    return frame

#I2C 및 PCA9685 초기화
driveI2C  = busio.I2C(board.SCL, board.SDA)
drivePCA = PCA9685(driveI2C)
drivePCA.frequency = 1000

leftMotor = PWMThrottleHat(drivePCA, channel=0)
rightMotor = PWMThrottleHat(drivePCA, channel=6)

SteerI2C = ExtI2C(7)
steerPCA = PCA9685(SteerI2C, address=0x60)
steerPCA.frequency = 50
steeringServo = servo.Servo(steerPCA.channels[0])
steeringAngle = 85  # 초기값

# 조향 각도 이동 함수
def setSteeringAngle(target):
    global steeringAngle
    if target != steeringAngle:
        step = 1 if target > steeringAngle else -1
        for angle in range(steeringAngle, target + step, step):
            steeringServo.angle = angle
            time.sleep(0.01)
        steeringAngle = target

# 주행 함수
def steerLeft():
    print("Turn Left")
    setSteeringAngle(40)
    leftMotor.setThrottle(0.5)
    rightMotor.setThrottle(0.5)

def steerRight():
    print("Turn Right")
    setSteeringAngle(130)
    leftMotor.setThrottle(0.5)
    rightMotor.setThrottle(0.5)

def goStraight():
    print("Go Straight")
    setSteeringAngle(85)
    leftMotor.setThrottle(0.5)
    rightMotor.setThrottle(0.5)

def stop():
    print("Stop")
    leftMotor.setThrottle(0)
    rightMotor.setThrottle(0)

# 카메라 설정
cap = cv2.VideoCapture(0)
cap.set(cv2.CAP_PROP_FRAME_WIDTH, 320)
cap.set(cv2.CAP_PROP_FRAME_HEIGHT, 240)

print("라인트레이싱 시작 (q 누르면 종료)")

try:
    while True:
        ret, frame = cap.read()
        if not ret:
            print("카메라 오류")
            break

        # ROI 및 이진화
        roi = frame[180:240, :]
        gray = cv2.cvtColor(roi, cv2.COLOR_BGR2GRAY)
        _, binary = cv2.threshold(gray, 100, 255, cv2.THRESH_BINARY_INV)

        direction = 'stop'
        M = cv2.moments(binary)

        if M['m00'] != 0:
            cx = int(M['m10'] / M['m00'])
            center = binary.shape[1] // 2
            offset = cx - center
            print(f"라인 중심: {cx}, 오프셋: {offset}")

            if offset > 20:
                direction = 'right'
                steerRight()
            elif offset < -20:
                direction = 'left'
                steerLeft()
            else:
                direction = 'forward'
                goStraight()
        else:
            print("선 인식 실패 , 정지")
            direction = 'stop'
            stop()

        # 디버깅 시각화
        frame = drawDirection(frame, direction)
        cv2.line(binary, (binary.shape[1] // 2, 0), (binary.shape[1] // 2, 60), (128), 2)
        cv2.imshow("Line Tracing", frame)
        cv2.imshow("Binary Line", binary)

        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

except KeyboardInterrupt:
    print("강제 종료됨")

finally:
    stop()
    cap.release()
    cv2.destroyAllWindows()
    driveI2C.deinit()
    steerPCA.deinit()
    print("프로그램 종료 및 모든 모터 정지 완료")

