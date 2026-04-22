#include <Wire.h>
#include <Adafruit_PWMServoDriver.h>

Adafruit_PWMServoDriver motorDriver = Adafruit_PWMServoDriver(0x60); // I2C 주소

#define SERVOMIN  150
#define SERVOMAX  600

int setAngle(int angle) {
  return map(angle, 0, 180, SERVOMIN, SERVOMAX);    // 각도가 들어오면 그 각도로 설정
}

// 서보모터 위치 (채널로 표시)

//     앞
//  ---------
// ㅣ10   13ㅣ
// ㅣ       ㅣ
// ㅣ       ㅣ
// ㅣ11   12ㅣ
//  ---------
//      뒤

void setup() {
  Serial.begin(9600);       // 시리얼 통신 시작
  // 1: 문 열고 5초 후 닫기 / 2: 잠금장치 열기 / 3: 잠금장치 잠그기
  
  motorDriver.begin();
  motorDriver.setOscillatorFrequency(27000000);
  motorDriver.setPWMFreq(60);                     // 모터 드라이버 초기 설정

  delay(10);    // 초기화 후 안정화

  // 초기 위치 설정 (실제 코드에서는 필요없을지도)
  motorDriver.setPWM(10, 0, setAngle(90));
  motorDriver.setPWM(11, 0, setAngle(90));
  motorDriver.setPWM(12, 0, setAngle(105));
  motorDriver.setPWM(13, 0, setAngle(105));   // 0,1,4,5 : 문 열고 닫기
  motorDriver.setPWM(15, 0, setAngle(90));   // 15 : 잠금장치
}

void openDoor() {
  for (int angle = 0; angle <= 90; angle++) {
    motorDriver.setPWM(10, 0, setAngle(90 - angle));
    motorDriver.setPWM(11, 0, setAngle(90 + angle));
    motorDriver.setPWM(12, 0, setAngle(105 - angle * 105 / 90));
    motorDriver.setPWM(13, 0, setAngle(105 + angle * 105 / 90));         // 90도 각도까지 문 열기
    delay(15);
  }
}

void closeDoor() {
  for (int angle = 90; angle >= 0; angle--) {
    motorDriver.setPWM(10, 0, setAngle(90 - angle));
    motorDriver.setPWM(11, 0, setAngle(90 + angle));
    motorDriver.setPWM(12, 0, setAngle(105 - angle * 105 / 90));
    motorDriver.setPWM(13, 0, setAngle(105 + angle * 105 / 90));         // 문 닫기
    delay(15);
  }
}

void lockDrawer() {
  motorDriver.setPWM(15, 0, setAngle(90));        // 잠금장치 잠그기
}

void unlockDrawer() {
  motorDriver.setPWM(15, 0, setAngle(0));         // 잠금장치 열기
}

void loop() {
  if (Serial.available()) {
    char serialInput = Serial.read();       // 입력 읽어오기

    // 1: 문 열고 5초 후 닫기 / 2: 잠금장치 열기 / 3: 잠금장치 잠그기
    if (serialInput == '1') {
      openDoor();
      delay(3000);       // 5초 대기
      closeDoor();
    } else if (serialInput == '2') {
      unlockDrawer();
    } else if (serialInput == '3') {
      lockDrawer();
    }
  }
}
