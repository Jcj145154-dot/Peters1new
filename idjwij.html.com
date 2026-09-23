<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>猜数字游戏</title>
    <style>
        body {
            font-family: sans-serif;
            text-align: center;
            margin-top: 50px;
        }
        .game-container {
            max-width: 400px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-shadow: 2px 2px 12px rgba(0,0,0,0.1);
        }
        input, button {
            padding: 10px;
            margin: 10px 0;
            font-size: 16px;
        }
    </style>
</head>
<body>
    <div class="game-container">
        <h1>猜数字游戏</h1>
        <p>我已经想好了一个 1 到 100 之间的数字。你能猜到它是多少吗？</p>
        <input type="number" id="guessInput" placeholder="输入你的猜测" min="1" max="100">
        <br>
        <button onclick="checkGuess()">提交</button>
        <p id="message"></p>
    </div>

    <script>
        const randomNumber = Math.floor(Math.random() * 100) + 1;
        let attempts = 0;

        function checkGuess() {
            const userGuess = parseInt(document.getElementById('guessInput').value);
            const message = document.getElementById('message');
            attempts++;

            if (isNaN(userGuess) || userGuess < 1 || userGuess > 100) {
                message.textContent = '请输入一个 1 到 100 之间的有效数字！';
                return;
            }

            if (userGuess === randomNumber) {
                message.textContent = `恭喜你！你猜对了！你一共猜了 ${attempts} 次。`;
                message.style.color = 'green';
            } else if (userGuess < randomNumber) {
                message.textContent = '太小了，再试一次！';
                message.style.color = 'red';
            } else {
                message.textContent = '太大了，再试一次！';
                message.style.color = 'red';
            }
        }
    </script>
</body>
</html>
