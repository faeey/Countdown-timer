<!DOCTYPE html>
<html>
<head>
  <title>Countdown Timer</title>
  <style>
    .timer-container {
      display: flex;
      flex-direction: column;
      align-items: center;
      position: relative;
      background: #001f3f; /* Dark blue background */
    }
    .timer {
      width: 100px;
      height: 50px;
      background: #0074c2;
      color: white;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 20px;
      border-radius: 5px;
      position: relative;
    }
    .diver {
      width: 100px;
      height: 20px;
      background: black;
      position: absolute;
      border-radius: 0 0 5px 5px;
      bottom: 0;
    }
    .gold-line {
      width: 100%;
      height: 2.5px; /* 50% thinner */
      background: gold;
      position: absolute;
      bottom: 0;
    }
  </style>
</head>
<body>
  <h1>Countdown Timer</h1>
  <div class="timer-container">
    <div class="timer" id="timer">01:00:00</div>
    <div class="gold-line"></div>
    <div class="diver" id="diver"></div>
  </div>
  <button id="startButton">Start</button>
  <button id="stopButton">Stop</button>
  <button id="addTimeButton">Add 15s</button>

  <script>
    let initialTime = 1 * 60 * 60; // 1 hour
    let maxAdditionalTime = 8 * 60 * 60; // Maximum additional time: 8 hours
    let timeLeft = initialTime;
    let intervalId = null;

    function updateTimerDisplay() {
      const hours = Math.floor(timeLeft / 3600);
      const minutes = Math.floor((timeLeft % 3600) / 60);
      const seconds = timeLeft % 60;
      const displayTime = `${String(hours).padStart(2, '0')}:${String(minutes).padStart(2, '0')}:${String(seconds).padStart(2, '0')}`;
      document.getElementById('timer').textContent = displayTime;

      // Update diver position
      const diver = document.getElementById('diver');
      const goldLine = document.querySelector('.gold-line');
      const additionalHeight = Math.max(0, Math.min(100, (timeLeft - initialTime) / maxAdditionalTime * 100));
      diver.style.bottom = `${additionalHeight}%`;
      goldLine.style.height = `${additionalHeight}%`;
    }

    document.getElementById('startButton').addEventListener('click', () => {
      if (!intervalId) {
        intervalId = setInterval(() => {
          if (timeLeft > 0) {
            timeLeft--;
            updateTimerDisplay();
          } else {
            clearInterval(intervalId);
            intervalId = null;
            alert('Time\'s up!');
          }
        }, 1000);
      }
    });

    document.getElementById('stopButton').addEventListener('click', () => {
      if (intervalId) {
        clearInterval(intervalId);
        intervalId = null;
      }
    });

    document.getElementById('addTimeButton').addEventListener('click', () => {
      if (timeLeft < initialTime + maxAdditionalTime) {
        timeLeft += 15; // Add 15 seconds
        updateTimerDisplay();
      }
    });

    updateTimerDisplay();
  </script>
</body>
</html>
