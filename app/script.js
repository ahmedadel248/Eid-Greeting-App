const messages = [

  "Kubernetes can wait... it's fattah time 🍚",

  "No more debugging today 😭",

  "Your only deployment now is meat 🍖",

  "Docker is running... now go celebrate 🎉",

  "Production issues can wait till tomorrow 😎",

  "No more working... it's Eid time 🌙",

  "Today's sprint is only eating and sleeping 🔥",

  "Forget deadlines... bring the fattah 😭"
];

function showGreeting() {

  const name =
    document.getElementById("nameInput").value;

  const message =
    document.getElementById("message");


  if(name.trim() === "") {

    message.innerHTML =
      "Enter your name first 😭";

    message.classList.add("show");

    return;
  }

  const randomMessage =
    messages[
      Math.floor(Math.random() * messages.length)
    ];

  message.classList.remove("show");

  void message.offsetWidth;

  message.innerHTML = `

    <div>
      🌙 Eid Mubarak ${name}
    </div>

    <div style="
      margin-top:15px;
      font-size:20px;
      color:#fde68a;
      line-height:1.8;
    ">
      ${randomMessage}
    </div>
  `;

  message.classList.add("show");

  confetti({

    particleCount: 250,

    spread: 140,

    origin: { y: 0.6 }
  });
}