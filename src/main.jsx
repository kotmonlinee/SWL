import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';
import ReactGA from 'react-ga4';

// 初始化GA（替换为你的测量ID）
ReactGA.initialize(import.meta.env.VITE_GOOGLE_ANALYTICS_PROJECT_ID);

// 跟踪初始页面浏览
ReactGA.send({ hitType: 'pageview', page: window.location.pathname });

// 渲染应用根组件
ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);

