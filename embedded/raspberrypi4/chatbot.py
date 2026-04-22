import sounddevice as sd
import queue
import time
from google.cloud import speech, texttospeech
import numpy as np
import datetime
from playsound import playsound
import os

def log(msg):
  print(f"[{datetime.datetime.now().strftime('%H:%M:%S.%f')[:-3]}] {msg}")

class RealtimeSTT:
  def __init__(self):
      self.rate = 44100
      self.chunk = int(self.rate / 20)
      self.q = queue.Queue()

      self.last_trigger_time = 0
      self.last_trigger_phrase = ""

      # Google STT
      self.stt_client = speech.SpeechClient()
      self.config = speech.RecognitionConfig(
          encoding=speech.RecognitionConfig.AudioEncoding.LINEAR16,
          sample_rate_hertz=self.rate,
          language_code="ko-KR",
      )
      self.streaming_config = speech.StreamingRecognitionConfig(
          config=self.config,
          interim_results=True,
      )

      # Google TTS
      self.tts_client = texttospeech.TextToSpeechClient()
      self.tts_voice = texttospeech.VoiceSelectionParams(
          language_code="ko-KR",
          name="ko-KR-Chirp3-HD-Leda",
          ssml_gender=texttospeech.SsmlVoiceGender.NEUTRAL
      )
      self.tts_audio_config = texttospeech.AudioConfig(
          audio_encoding=texttospeech.AudioEncoding.MP3,
          speaking_rate=1.0,
      )

  def audioCallback(self, indata, frames, time_info, status):
      if status:
          log(f"오디오 상태 문제: {status}")
      self.q.put(indata.copy())

  def generator(self):
      log("오디오 스트림 시작")
      for _ in range(3):
          self.q.put(np.zeros((self.chunk, 1), dtype=np.int16))
      while True:
          try:
              chunk = self.q.get(timeout=1)
          except queue.Empty:
              log("오디오 입력 없음 (1초 타임아웃)")
              continue
          if chunk is None:
              break
          yield speech.StreamingRecognizeRequest(audio_content=chunk.tobytes())

  def speakText(self, text):
      if not text:
          log("출력할 문장이 없어 TTS 생략됨")
          return
      log(f"음성 출력: {text}")
      synthesis_input = texttospeech.SynthesisInput(text=text)
      response = self.tts_client.synthesize_speech(
          input=synthesis_input,
          voice=self.tts_voice,
          audio_config=self.tts_audio_config
      )
      with open("output.mp3", "wb") as out:
          out.write(response.audio_content)
      playsound("output.mp3")
      os.remove("output.mp3")

  def listenPrintLoop(self, responses):
      for response in responses:
          if not response.results:
              continue
          result = response.results[0]
          if not result.alternatives:
              continue

          transcript = result.alternatives[0].transcript.strip()
          transcript_nospace = transcript.replace(" ", "")
          print(f"인식됨: {transcript}")

          # 즉시 응답 트리거
          immediate_response_map = {
              ("너는뭐야", "넌뭐야", "넌누구니", "너는누구니"): "안녕 나는 요기야. 잃어버린 물건을 찾아줄게",
              ("자기소개", "소개해줘", "자기소개해봐"): "안녕하세요 여러분. 저는 요기예요. 여러분의 잃어버린 소중한 추억들을 찾아줄게요.",
              ("너가요기니", "네가요기니", "너가여기니", "네가여기니"): "맞아 나는 요기야. 잃어버린 물건을 찾으러 온거야?"
          }

          now = time.time()
          for keys, reply in immediate_response_map.items():
              if any(k in transcript_nospace for k in keys):
                  matched_key = [k for k in keys if k in transcript_nospace][0]

                  # 5초 이내 같은 문장 반복 방지
                  if matched_key == self.last_trigger_phrase and now - self.last_trigger_time < 5:
                      print("같은 질문 반복 인식 → 무시")
                      return

                  self.last_trigger_time = now
                  self.last_trigger_phrase = matched_key

                  log(f"즉시 응답 트리거 감지: {transcript}")
                  self.speakText(reply)

                  # ✅ 오디오 큐 초기화
                  with self.q.mutex:
                      self.q.queue.clear()

                  # ✅ 스트리밍 세션 종료 → start()에서 재시작
                  return

  def start(self):
      log("실시간 음성 인식을 시작합니다.")
      try:
          while True:
              with sd.InputStream(samplerate=self.rate, channels=1, dtype='int16',
                                  blocksize=self.chunk, callback=self.audioCallback, device=2):
                  audio_generator = self.generator()
                  responses = self.stt_client.streaming_recognize(self.streaming_config, audio_generator)
                  self.listenPrintLoop(responses)
      except KeyboardInterrupt:
          log("수동 종료됨 (Ctrl+C)")
      except Exception as e:
          log(f"오류 발생: {e}")

if __name__ == "__main__":
  stt = RealtimeSTT()
  stt.start()
