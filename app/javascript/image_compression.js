// import imageCompression from 'browser-image-compression';

// document.addEventListener('turbo:load', () => {
  // 単一画像アップロード（photo_url）
//   const photoInput = document.querySelector('#review_photo_url');

//   if (photoInput) {
//     photoInput.addEventListener('change', async (event) => {
//       const file = event.target.files[0];
//       if (!file || !file.type.startsWith('image/')) return;

//       const options = {
//         maxSizeMB: 0.5,  // 500KB以下に圧縮
//         maxWidthOrHeight: 1200,  // 幅/高さを1200px以下に
//         useWebWorker: true
//       };

//       try {
//         // ★★★ デバッグコード ★★★
//         console.log('=== 画像圧縮開始 ===');
//         console.log('元のファイル名:', file.name);
//         console.log('元のサイズ:', (file.size / 1024).toFixed(2), 'KB');

//         const compressedFile = await imageCompression(file, options);

//         console.log('圧縮後のサイズ:', (compressedFile.size / 1024).toFixed(2), 'KB');
//         console.log('圧縮率:', ((1 - compressedFile.size / file.size) * 100).toFixed(1), '%削減');
//         console.log('=== 画像圧縮完了 ===');

//         // 圧縮後のファイルをinputに再設定
//         const dataTransfer = new DataTransfer();
//         dataTransfer.items.add(compressedFile);
//         photoInput.files = dataTransfer.files;

//       } catch (error) {
//         console.error('圧縮エラー:', error);
//       }
//     });
//   }

  // 複数画像アップロード（main_images_images）
//   const mainImagesInput = document.querySelector('input[name="review[main_images_images][]"]');

//   if (mainImagesInput) {
//     mainImagesInput.addEventListener('change', async (event) => {
//       const files = Array.from(event.target.files);
//       if (files.length === 0) return;

//       const options = {
//         maxSizeMB: 0.5,
//         maxWidthOrHeight: 1200,
//         useWebWorker: true
//       };

//       try {
//         const dataTransfer = new DataTransfer();

//         console.log('=== 複数画像圧縮開始 ===');
//         console.log('画像数:', files.length);

//         for (let i = 0; i < files.length; i++) {
//           const file = files[i];

//           if (!file.type.startsWith('image/')) {
//             dataTransfer.items.add(file);
//             continue;
//           }

//           console.log(`\n[${i + 1}/${files.length}] ${file.name}`);
//           console.log('元のサイズ:', (file.size / 1024).toFixed(2), 'KB');

//           const compressedFile = await imageCompression(file, options);

//           console.log('圧縮後:', (compressedFile.size / 1024).toFixed(2), 'KB');

//           dataTransfer.items.add(compressedFile);
//         }

//         mainImagesInput.files = dataTransfer.files;
//         console.log('=== 複数画像圧縮完了 ===');

//       } catch (error) {
//         console.error('圧縮エラー:', error);
//       }
//     });
//   }
//});
