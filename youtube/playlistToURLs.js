let textArea = document.createElement("textarea");
textArea.setAttribute("id", "ytb_cus_list");
textArea.value = Array.from(document.querySelectorAll("a#video-title[class*='playlist']"), (a) => a.href).join("\n");
document.body.appendChild(textArea);
document.querySelector("#ytb_cus_list").select();
document.execCommand("copy");