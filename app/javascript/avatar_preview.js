document.addEventListener("DOMContentLoaded", () => {
  console.log("✅ JavaScript がロードされました");

  const avatarInput = document.getElementById("avatar-upload");
  const previewImage = document.getElementById("avatar-preview");

  if (!avatarInput || !previewImage) {
    console.warn("⚠ 必要な要素が見つかりませんでした");
    return;
  }

  console.log("✅ アバター画像の input:", avatarInput);
  console.log("✅ プレビュー用の img:", previewImage);

  avatarInput.addEventListener("change", (event) => {
    console.log("✅ アバター画像が選択されました");

    if (!event.target.files.length) {
      console.warn("⚠ ファイルが選択されていません");
      return;
    }

    const file = event.target.files[0];

    if (!file.type.startsWith("image/")) {
      console.error("❌ 選択されたファイルは画像ではありません");
      return;
    }

    const reader = new FileReader();
    reader.onload = (e) => {
      console.log("✅ プレビュー画像を更新");
      previewImage.src = e.target.result;
    };
    reader.readAsDataURL(file);
  });
});
