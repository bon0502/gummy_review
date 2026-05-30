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

// ページ読み込み完了時の処理
document.addEventListener('DOMContentLoaded', () => {
  // ページが完全に読み込まれたらローディングを非表示
  hideGummyLoading();

  // フォーム送信時にローディングを表示
  const forms = document.querySelectorAll('form');
  forms.forEach(form => {
    form.addEventListener('submit', (event) => {
      showGummyLoading();
    });
  });
});

// Turbo使用時の制御
// リンクをクリックした時にローディングを表示
document.addEventListener('turbo:click', () => {
  showGummyLoading();
});

// ページ遷移が完了したらローディングを非表示
document.addEventListener('turbo:load', () => {
  hideGummyLoading();
});

// フォーム送信時にローディングを表示
document.addEventListener('turbo:submit-start', () => {
  showGummyLoading();
});

// フォーム送信完了時にローディングを非表示
document.addEventListener('turbo:submit-end', () => {
  hideGummyLoading();
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

// フェードアニメーション付きでメッセージを変更
function changeMessageWithFade() {
  const loadingMessage = document.getElementById('loadingMessage');

  if (!loadingMessage) return;

  // フェードアウト
  loadingMessage.style.opacity = '0';

  setTimeout(() => {
    // メッセージを変更
    loadingMessage.textContent = getRandomMessage();

    // フェードイン
    loadingMessage.style.opacity = '1';
  }, 300); // 0.3秒後に変更
}

function startMessageRotation() {
  const loadingMessage = document.getElementById('loadingMessage');

  if (!loadingMessage) return;

  // ⭐ 既にインターバルが動いている場合は停止
  if (messageInterval) {
    clearInterval(messageInterval);
  }

  // ⭐ 初回メッセージをランダムに設定
  loadingMessage.textContent = getRandomMessage();

  // ⭐ 1.5秒後に最初のメッセージ変更を実行
  setTimeout(() => {
    changeMessageWithFade();
    
    // ⭐ その後は2.5秒ごとにメッセージを変更
    messageInterval = setInterval(changeMessageWithFade, 2500);
  }, 1500); // 初回は1.5秒後に変更
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
    // hiddenクラスを削除してローディング画面を表示
    overlay.classList.remove('hidden');
    startMessageRotation();
  }
});

// ⭐ 初回ページ読み込み完了時
window.addEventListener('load', () => {
  const overlay = document.getElementById('gummyLoadingOverlay');
  
  if (overlay) {
    // ⭐ 少し遅延させてから非表示にする(最低2回はメッセージ変更を見せるため)
    setTimeout(() => {
      overlay.classList.add('hidden');
      stopMessageRotation();
    }, 4500); // 4.5秒後に非表示
  }
});

// ⭐ Turboのページ遷移開始時にローディング画面を表示
document.addEventListener('turbo:before-fetch-request', () => {
  const overlay = document.getElementById('gummyLoadingOverlay');
  
  if (overlay) {
    overlay.classList.remove('hidden');
    startMessageRotation();
  }
});

// ⭐ Turboのページ読み込み完了時にローディング画面を非表示
document.addEventListener('turbo:load', () => {
  const overlay = document.getElementById('gummyLoadingOverlay');
  
  if (overlay) {
    overlay.classList.add('hidden');
    stopMessageRotation();
  }
});
