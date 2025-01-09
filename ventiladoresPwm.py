import RPi.GPIO as GPIO
import time
import os

# Configuración del pin GPIO para PWM
FAN_PIN = 18  
GPIO.setmode(GPIO.BCM)
GPIO.setup(FAN_PIN, GPIO.OUT)

# Configuración de PWM
fan_pwm = GPIO.PWM(FAN_PIN, 25)  # Frecuencia inicial de 25 Hz
fan_pwm.start(0)  # Inicia el PWM con duty cycle 0%

# Función para leer la temperatura del CPU
def get_cpu_temperature():
    temp_output = os.popen("vcgencmd measure_temp").readline()
    temp = float(temp_output.replace("temp=", "").replace("'C\n", ""))
    return temp

# Función para calcular el duty cycle en función de la temperatura
def calculate_fan_speed(temp):
    if temp < 40:
        return 0  # Apagar ventilador
    elif temp < 50:
        return 25  # Velocidad baja
    elif temp < 60:
        return 50  # Velocidad media
    elif temp < 70:
        return 75  # Velocidad alta
    else:
        return 100  # Velocidad máxima

try:
    while True:
        cpu_temp = get_cpu_temperature()
        fan_speed = calculate_fan_speed(cpu_temp)
        fan_pwm.ChangeDutyCycle(fan_speed)
        print(f"Temperatura: {cpu_temp}°C, Velocidad del ventilador: {fan_speed}%")
        time.sleep(5)  # Ajustar cada 5 segundos
except KeyboardInterrupt:
    print("Saliendo...")
finally:
    fan_pwm.stop()
    GPIO.cleanup()
