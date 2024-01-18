
import { Socket } from "phoenix"
let socket = new Socket("/socket", { params: { token: window.userToken } })
socket.connect()

let channel = socket.channel("room:lobby", {})

channel.on("new_msg", payload => {
  console.log(payload.body);
  drawRectangle()
})

channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

export const Game = {
  mounted() {
    let myParam = this.el.dataset.myParam;
    console.log("Hook mounted with parameter:", myParam);
    document.addEventListener("keydown", function (event) {
      if (event.code === "Space") {


        console.log("Spacebar pressed");
        channel.push("specebar_pressed", { key: "value" });


        // Optional: Prevent the default action of the spacebar (scrolling)
        event.preventDefault();
      }
    });

  }
}

function drawRectangle() {
  var rectangle = document.createElement("div");
  rectangle.style.width = "100px";
  rectangle.style.height = "100px";
  rectangle.style.backgroundColor = "red";
  rectangle.style.position = "absolute";
  rectangle.style.top = "50%";
  rectangle.style.left = "50%";
  rectangle.style.transform = "translate(-50%, -50%)";

  var container = document.getElementById("rectangle-container");
  container.appendChild(rectangle);
}