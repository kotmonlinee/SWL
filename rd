
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Spin & Win!</title>
    <style>
      .modal-overlay {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.7);
        z-index: 1000;
        justify-content: center;
        align-items: center;
      }

      .modal {
        background: linear-gradient(135deg, #2c2c2c, #1a1a1a);
        padding: 30px;
        border-radius: 20px;
        text-align: center;
        max-width: 75%;
        width: 400px;
        position: relative;
        border: 2px solid #ff007f;
        box-shadow: 0 0 20px rgba(255, 0, 127, 0.3);
      }

      .modal h2 {
        color: #fff;
        margin-bottom: 20px;
        font-size: 24px;
      }

      .modal p {
        color: #ddd;
        margin-bottom: 25px;
        font-size: 18px;
        line-height: 1.5;
      }
      .modal img {
        width: 100%;
      }
      .modal-btn {
        background: #ff007f;
        color: white;
        border: none;
        padding: 12px 30px;
        border-radius: 25px;
        font-size: 18px;
        cursor: pointer;
        transition: all 0.3s ease;
        box-shadow: 0 0 15px rgba(255, 0, 127, 0.4);
      }

      .modal-btn:hover {
        transform: scale(1.05);
        box-shadow: 0 0 20px rgba(255, 0, 127, 0.6);
      }

      body {
        margin: 0;
        padding: 0;
        font-family: "Poppins", sans-serif;
        background: linear-gradient(135deg, #1f1c2c, #928dab);
        color: #fff;
        text-align: center;
        overflow-x: hidden;
      }

      h1 {
        margin-top: 40px;
        font-size: 2.5em;
      }

      #countdown {
        font-size: 1.2em;
        margin: 10px auto;
        color: #fffb00;
        animation: pulse 1.5s infinite;
      }

      @keyframes pulse {
        0% {
          opacity: 1;
        }
        50% {
          opacity: 0.5;
        }
        100% {
          opacity: 1;
        }
      }

      .wheel-container {
        margin: 20px auto;
        width: 344px;
        height: 344px;
        border-radius: 50%;
        background: #ff007f;
        box-shadow: 0 0 20px rgba(255, 255, 255, 0.4);
        position: relative;
        display: flex;
        justify-content: center;
        align-items: center;
      }

      #wheel {
        width: 320px;
        height: 320px;
        border-radius: 50%;
        background-image: url("./img/prizewheel-amazon_2.png?1");
        background-size: cover;
        transition: transform 4s ease-out;
        position: relative;
      }

      #pointer {
        width: 0;
        height: 0;
        border-left: 15px solid transparent;
        border-right: 15px solid transparent;
        border-bottom: 30px solid #ff007f;
        position: absolute;
        top: 12px;
        left: 50%;
        transform: translateX(-50%) rotate(180deg);
        z-index: 10;
        /* filter: drop-shadow(0 0 5px rgba(0, 0, 0, 0.3)); */
      }

      #messages {
        margin-top: 30px;
        height: 30px;
        overflow: hidden;
        font-size: 0.95em;
        color: #cccccc;
      }

      #messages div {
        animation: scrollUp 12s linear infinite;
      }

      @keyframes scrollUp {
        0% {
          transform: translateY(100%);
        }
        100% {
          transform: translateY(-300%);
        }
      }
    </style>
    <script type="text/javascript">
      (function (c, l, a, r, i, t, y) {
        c[a] =
          c[a] ||
          function () {
            (c[a].q = c[a].q || []).push(arguments);
          };
        t = l.createElement(r);
        t.async = 1;
        t.src = "https://www.clarity.ms/tag/" + i;
        y = l.getElementsByTagName(r)[0];
        y.parentNode.insertBefore(t, y);
      })(window, document, "clarity", "script", "sfodajfpek");
    </script>
  </head>
  <body>
    <div id="welcomeModal" class="modal-overlay">
      <div class="modal">
        <h2>🎁 Special Offer!</h2>
        <p>
          Spin the wheel for a chance to win $500 Cash App reward! Don't miss out
          on this amazing opportunity!
        </p>
        <button class="modal-btn" onclick="closeWelcomeModal()">
          Try My Luck! 🎯
        </button>
      </div>
    </div>

    <div id="tryAgainModal" class="modal-overlay">
      <div class="modal">
        <h2>😮 Almost There!</h2>
        <p>
          So close! Give it another spin - your $500 Cash App reward might be just
          one spin away!
        </p>
        <button class="modal-btn" onclick="closeTryAgainModal()">
          Spin Again! 🎡
        </button>
      </div>
    </div>

    <div id="winModal" class="modal-overlay">
      <div class="modal">
        <h2>🎉 Congratulations!</h2>
        <img src="./img/cash500.png?1" />
        <p>You've won a $500 Cash App reward! Click below to claim your prize!</p>
        <button
          class="modal-btn"
          onclick="window.location.href='https://track.financialswingcoach.com/cf/click/1'"
        >
          Claim Now! 💰
        </button>
      </div>
    </div>

    <h1>🎯 Spin & Win Big!</h1>
    <div id="countdown">
      ⏰ Hurry! Only <span id="timer">60</span> seconds left to spin!
    </div>
    <div class="wheel-container">
      <div id="pointer"></div>
      <div id="wheel"></div>
    </div>
    <div id="messages">
      <div>
        <p>🎉 Jason from NYC just won a $50 gift card!</p>
        <p>🎁 Emily from LA got a free T-shirt!</p>
        <p>👏 Mike from Chicago unlocked VIP access!</p>
        <p>🔥 Sarah from Miami won 30% off!</p>
      </div>
    </div>

    <script>
      const wheel = document.getElementById("wheel");
      const welcomeModal = document.getElementById("welcomeModal");
      const tryAgainModal = document.getElementById("tryAgainModal");
      const winModal = document.getElementById("winModal");
      const timerEl = document.getElementById("timer");

      let spinCount = 0;
      let isSpinning = false;

      window.onload = function () {
        welcomeModal.style.display = "flex";
      };

      function closeWelcomeModal() {
        welcomeModal.style.display = "none";
        spinWheel();
      }

      function closeTryAgainModal() {
        tryAgainModal.style.display = "none";
        spinWheel();
      }

      function spinWheel() {
        if (isSpinning) return;
        isSpinning = true;

        // const baseDeg =
        //   spinCount === 0
        //     ? 3600 + 45
        //     : wheel.style.transform
        //     ? parseInt(wheel.style.transform.match(/rotate\((\d+)deg\)/)[1]) +
        //       3600
        //     : 3600;
        const baseDeg =
          spinCount === 0
            ? 1800 + 45 
            : spinCount === 1
            ? 3780 
            : parseInt(wheel.style.transform.match(/rotate\((\d+)deg\)/)[1]) +
              3600; 
        // const deg = spinCount === 0 ? 3600 + 45 : 3600 + 180;
        console.log(baseDeg, "basedeo");

        console.log(spinCount, "spinCount");
        // const randomDeg = Math.floor(Math.random() * 360);
        const deg = baseDeg;
        console.log(deg, "deg");

        wheel.style.transform = `rotate(${deg}deg)`;

        setTimeout(() => {
          isSpinning = false;
          spinCount++;

          if (spinCount >= 2) {
            winModal.style.display = "flex";
          } else {
            tryAgainModal.style.display = "flex";
          }
        }, 4000);
      }

      let countdown = 60;
      const timer = setInterval(() => {
        countdown--;
        timerEl.textContent = countdown;
        if (countdown <= 0) {
          clearInterval(timer);
          document.getElementById("countdown").textContent =
            "⛔ Time's up! Try again tomorrow.";
        }
      }, 1000);
    </script>
  </body>
  <div id="reviews">
    <div class="review-container">
      <div class="review-track">
        <div class="review">
          <img src="./img/1.jpg" alt="User 1" />
          <p>
            "Just won $500 on Cash App! Can't believe my luck! 🎉"<br /><span
              >- Emma, Seattle, WA</span
            >
          </p>
        </div>
        <div class="review">
          <img src="./img/2.jpg" alt="User 2" />
          <p>
            "This is legit! Got my $500 Cash App reward instantly."<br /><span
              >- Marcus, Austin, TX</span
            >
          </p>
        </div>
        <div class="review">
          <img src="./img/3.jpg" alt="User 3" />
          <p>
            "Best surprise ever! $500 straight to my Cash App! 💸"<br /><span
              >- Sarah, Miami, FL</span
            >
          </p>
        </div>
        <div class="review">
          <img src="./img/4.jpg" alt="User 4" />
          <p>
            "Told my friends about it - we all got the $500 bonus!"<br /><span
              >- James, Denver, CO</span
            >
          </p>
        </div>
        <div class="review">
          <img src="./img/5.jpg" alt="User 5" />
          <p>
            "Quick and easy $500 reward. Thanks Cash App! 🙌"<br /><span
              >- Richard, Portland, OR</span
            >
          </p>
        </div>
        <!-- <div class="review">
          <img src="./img/6.jpg" alt="User 6" />
          <p>
            "Never thought I'd win, but here I am $500 richer!"<br /><span
              >- Ryan, Phoenix, AZ</span
            >
          </p>
        </div> -->
        <!-- 第二组评论（复制第一组，实现无缝效果） -->
        <div class="review">
          <img src="./img/1.jpg" alt="User 1" />
          <p>
            "Just won $500 on Cash App! Can't believe my luck! 🎉"<br /><span
              >- Emma, Seattle, WA</span
            >
          </p>
        </div>
        <div class="review">
          <img src="./img/2.jpg" alt="User 2" />
          <p>
            "This is legit! Got my $500 Cash App reward instantly."<br /><span
              >- Marcus, Austin, TX</span
            >
          </p>
        </div>
        <div class="review">
          <img src="./img/3.jpg" alt="User 3" />
          <p>
            "Best surprise ever! $500 straight to my Cash App! 💸"<br /><span
              >- Sarah, Miami, FL</span
            >
          </p>
        </div>
        <div class="review">
          <img src="./img/4.jpg" alt="User 4" />
          <p>
            "Told my friends about it - we all got the $500 bonus!"<br /><span
              >- James, Denver, CO</span
            >
          </p>
        </div>
        <div class="review">
          <img src="./img/5.jpg" alt="User 5" />
          <p>
            "Quick and easy $500 reward. Thanks Cash App! 🙌"<br /><span
              >- Richard, Portland, OR</span
            >
          </p>
        </div>
        <!-- <div class="review">
          <img src="6.jpg" alt="User 6" />
          <p>
            "Never thought I'd win, but here I am $500 richer!"<br /><span
              >- Ryan, Phoenix, AZ</span
            >
          </p>
        </div> -->
      </div>
    </div>
  </div>

  <style>
    #reviews {
      margin-top: 50px;
      background-color: #2d2d2d;
      padding: 30px 10px;
      color: #fff;
    }

    #reviews h2 {
      font-size: 1.8em;
      margin-bottom: 20px;
    }

    .review-container {
      width: 80%;
      max-width: 1200px;
      margin: 0 auto;
      overflow: hidden;
      position: relative;
    }

    .review-track {
      display: flex;
      animation: scrollReviews 25s linear infinite;
      /* 复制一份评论以实现无缝轮播 */
      content: "";
    }

    /* 移动端适配 */
    @media screen and (max-width: 768px) {
      .review-container {
        width: 95%;
      }

      .review-track {
        animation: scrollReviews 15s linear infinite;
      }
    }
    /* 创建无限滚动动画 */
    @keyframes scrollReviews {
      0% {
        transform: translateX(0);
      }
      100% {
        transform: translateX(-100%);
      }
    }

    .review {
      display: flex;
      align-items: center;
      min-width: 300px;
      max-width: 400px;
      margin: 0 15px;
      background: rgba(255, 255, 255, 0.05);
      border-radius: 12px;
      padding: 15px;
    }

    .review img {
      width: 45px;
      height: 45px;
      border-radius: 50%;
      margin-right: 15px;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      object-fit: cover;
      background: #444;
    }

    .review p {
      font-size: 0.95em;
      line-height: 1.4em;
    }

    .review span {
      display: block;
      font-size: 0.8em;
      color: #aaa;
      margin-top: 5px;
    }

    @keyframes scrollReviews {
      0% {
        transform: translateX(0);
      }
      100% {
        transform: translateX(-100%);
      }
    }
  </style>
</html>
