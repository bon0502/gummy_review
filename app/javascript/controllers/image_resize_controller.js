import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["main", "sub"];

  async resizeMain(event) {
    const file = event.target.files[0];
    if (!file) return;

    const resized = await this.resizeImage(file, 800, 800);
    this.replaceFileInput(this.mainTarget, [resized], file.name);
  }

  async resizeSub(event) {
    const files = Array.from(event.target.files);
    if (files.length === 0) return;

    const resizedFiles = [];

    for (const file of files) {
      const resized = await this.resizeImage(file, 300, 300);
      resizedFiles.push(resized);
    }

    this.replaceFileInput(this.subTarget, resizedFiles, "resized");
  }

  resizeImage(file, maxWidth, maxHeight) {
    return new Promise((resolve) => {
      const img = new Image();
      const reader = new FileReader();

      reader.onload = (e) => (img.src = e.target.result);

      img.onload = () => {
        let width = img.width;
        let height = img.height;

        const ratio = Math.min(maxWidth / width, maxHeight / height);
        width *= ratio;
        height *= ratio;

        const canvas = document.createElement("canvas");
        canvas.width = width;
        canvas.height = height;

        const ctx = canvas.getContext("2d");
        ctx.drawImage(img, 0, 0, width, height);

        canvas.toBlob(
          (blob) => resolve(blob),
          "image/jpeg",
          0.8
        );
      };

      reader.readAsDataURL(file);
    });
  }

  replaceFileInput(input, blobs, fileName) {
    const dataTransfer = new DataTransfer();

    blobs.forEach((blob, index) => {
      const file = new File([blob], `${fileName}_${index}.jpg`, {
        type: "image/jpeg",
      });
      dataTransfer.items.add(file);
    });

    input.files = dataTransfer.files;
  }
}
