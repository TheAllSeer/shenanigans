//nav bar

const navi = document.querySelector(".nav-ul");
const toggle = document.querySelector("#burger");

toggle.addEventListener("click", () => {
  const vis = navi.getAttribute("data-visible");
  if (vis === "true") {
    navi.setAttribute("data-visible", false);
    navi.setAttribute("aria-expanded", false);
  } else {
    navi.setAttribute("data-visible", true);
    navi.setAttribute("aria-expanded", true);
  }
});

//gallery

const gallerySlide = document.querySelector(".gallery-images");
const galleryImages = document.querySelectorAll(".gallery-images img");

const prevB = document.querySelector("#prev-button");
const nextB = document.querySelector("#next-button");

let counter = 1;

// const size = document.getElementById("last-clone").clientWidth;
const size = galleryImages[0].clientWidth;

gallerySlide.style.transform = "translateX(" + -size * counter + "px)";

//buttons event listeners

nextB.addEventListener("click", () => {
  if (counter >= galleryImages.length - 1) return;
  gallerySlide.style.transition = "transform 0.4s ease-in";
  counter++;
  gallerySlide.style.transform = "translateX(" + -size * counter + "px)";
});

prevB.addEventListener("click", () => {
  if (counter <= 0) return;
  gallerySlide.style.transition = "transform .4s ease-in";
  counter--;
  gallerySlide.style.transform = "translateX(" + -size * counter + "px)";

  console.log(size);
});

//transitionends to detect last&first clones

gallerySlide.addEventListener("transitionend", () => {
  if (galleryImages[counter].id === "last-clone") {
    gallerySlide.style.transition = "none";
    counter = galleryImages.length - 2;
    gallerySlide.style.transform = "translateX(" + -size * counter + "px)";
  }
});

gallerySlide.addEventListener("transitionend", () => {
  if (galleryImages[counter].id === "first-clone") {
    gallerySlide.style.transition = "none";
    counter = galleryImages.length - counter;
    gallerySlide.style.transform = "translateX(" + -size * counter + "px)";
  }
});
