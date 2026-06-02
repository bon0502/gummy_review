// esbuildを使用したJavaScriptのエントリーポイント
import "@hotwired/turbo-rails"
import "./controllers"
import "browser-image-compression"
import "chartkick/chart.js"

// ローディングを表示する関数
function showGummyLoading() {
  const overlay = document.getElementById('gummyLoadingOverlay');
  if (overlay) {
    overlay.classList.remove('hidden');
  }
}

// ローディングを非表示にする関数
function hideGummyLoading() {
  const overlay = document.getElementById('gummyLoadingOverlay');
  if (overlay) {
    overlay.classList.add('hidden');
  }
}

// ⭐ Turboのフォーム送信開始時にローディングを表示
document.addEventListener('turbo:submit-start', () => {
  showGummyLoading();
  startMessageRotation();
});

// ⭐ Turboのフォーム送信完了時にローディングを非表示
document.addEventListener('turbo:submit-end', () => {
  hideGummyLoading();
  stopMessageRotation();
});

// render :new などでビューが再描画された時にローディングを非表示
document.addEventListener('turbo:render', () => {
  hideGummyLoading();
  stopMessageRotation();
});

// ⭐ Turboのページ遷移開始時にローディングを表示
document.addEventListener('turbo:before-fetch-request', () => {
  showGummyLoading();
  startMessageRotation();
});

// ⭐ Turboのページ読み込み完了時にローディングを非表示
document.addEventListener('turbo:load', () => {
  hideGummyLoading();
  stopMessageRotation();
});

const loadingMessages = [
  '読み込み中...☁️',
  'ちょっと待ってねグミが逃げました!追いかけ中🏃‍♂️',
  'グミたちが並ぶ順番で揉めています😳',
  'グミの気持ちを確認中🤔',
  'グミ会議を開催しています📝',
  'グミがダンスしているのを見守っています💃',
  'グミの行列ができています🍬',
  'グミの準備が整うまで少々お待ちください⏳',
  'グミの世界に旅立っています🌍',
  'グミがこちらを見ています👀'
];

let messageInterval = null;

function getRandomMessage() {
  const randomIndex = Math.floor(Math.random() * loadingMessages.length);
  return loadingMessages[randomIndex];
}

function changeMessageWithFade() {
  const loadingMessage = document.getElementById('loadingMessage');

  if (!loadingMessage) return;

  loadingMessage.style.opacity = '0';

  setTimeout(() => {
    loadingMessage.textContent = getRandomMessage();
    loadingMessage.style.opacity = '1';
  }, 300);
}

function startMessageRotation() {
  const loadingMessage = document.getElementById('loadingMessage');

  if (!loadingMessage) return;

  if (messageInterval) {
    clearInterval(messageInterval);
  }

  loadingMessage.textContent = getRandomMessage();

  setTimeout(() => {
    changeMessageWithFade();
    messageInterval = setInterval(changeMessageWithFade, 2500);
  }, 1500);
}

function stopMessageRotation() {
  if (messageInterval) {
    clearInterval(messageInterval);
    messageInterval = null;
  }
}

// ⭐ 初回ページ読み込み時
document.addEventListener('DOMContentLoaded', () => {
  const overlay = document.getElementById('gummyLoadingOverlay');
  
  if (overlay) {
    overlay.classList.remove('hidden');
    startMessageRotation();
  }
});

// ⭐ 初回ページ読み込み完了時
window.addEventListener('load', () => {
  const overlay = document.getElementById('gummyLoadingOverlay');
  
  if (overlay) {
    setTimeout(() => {
      overlay.classList.add('hidden');
      stopMessageRotation();
    }, 4500);
  }
});

document.addEventListener('turbo:load', () => {
  // 削除ボタンのイベントリスナー
  document.querySelectorAll('.remove-image').forEach(button => {
    button.addEventListener('click', (e) => {
      const imageItem = e.target.closest('.main-image-item');
      const destroyFlag = imageItem.querySelector('.destroy-flag');
      
      // 削除マークをつける
      destroyFlag.value = '1';
      
      // 非表示にする
      imageItem.style.display = 'none';
    });
  });
});
