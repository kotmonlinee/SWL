import React, { useState, useEffect, useRef } from 'react';
import './App.css';
import prizewheelBg from './prizewheel-bg.jpg';
import walmartImage from './walmart-bg.png';
import ReactGA from 'react-ga4';  

// 主应用组件
function App() {
  // 状态管理
  const [spinCount, setSpinCount] = useState(0);
  const [isSpinning, setIsSpinning] = useState(false);
  const [rotation, setRotation] = useState(0);
  const [remainingTime, setRemainingTime] = useState(60);
  const [showWelcomeModal, setShowWelcomeModal] = useState(true);
  const [showTryAgainModal, setShowTryAgainModal] = useState(false);
  const [showWinModal, setShowWinModal] = useState(false);
  const wheelRef = useRef(null);

  // 在组件顶部添加URL参数解析函数
  const getUrlParam = (name) => {
    const params = new URLSearchParams(window.location.search);
    return params.get(name) || '';
  };

  // 在组件函数内添加状态和副作用
  const [clickId, setClickId] = useState('');

  useEffect(() => {
    // 页面加载时获取click_id参数
    const id = getUrlParam('click_id');
    setClickId(id);
  }, []);

  // 在组件挂载时检查Clarity初始化状态
  useEffect(() => {
    const checkClarity = setInterval(() => {
      if (window.clarityInitialized) {
        console.log('Clarity loaded successfully');
        clearInterval(checkClarity);
      }
    }, 100);

    return () => clearInterval(checkClarity);
  }, []);

  // 倒计时逻辑
  useEffect(() => {
    if (remainingTime > 0 && !showWelcomeModal) {
      const timer = setTimeout(() => setRemainingTime(prev => prev - 1), 1000);
      return () => clearTimeout(timer);
    }
  }, [remainingTime, showWelcomeModal]);

  // 转盘旋转逻辑
  const spinWheel = () => {
    if (isSpinning || remainingTime <= 0) return;
    setIsSpinning(true);

    // 强制回流以确保过渡动画触发
    if (wheelRef.current) wheelRef.current.offsetHeight;

    // 根据需求文档设置固定停止位置
    const baseDegrees = spinCount === 0 ? 3600 + 45 : 5400 + 135; // 10圈+90度 或 15圈+135度，增强视觉效果
    setRotation(prevRotation => prevRotation + baseDegrees);

    // 旋转结束后处理
    setTimeout(() => {
      setIsSpinning(false);
      setSpinCount(prev => prev + 1);

      if (spinCount === 0) {
        setShowTryAgainModal(true);
      } else if (spinCount === 1) {
        setShowWinModal(true);
      }
    }, 5000); // 匹配需求文档中的4秒旋转动画
    // 发送GA事件
    ReactGA.event({
      category: 'Wheel',
      action: 'Spin',
      label: `Attempt_${spinCount}`,
      value: spinCount + 1,
      nonInteraction: false
    });

    // 发送 Clarity 自定义事件
    // 转盘旋转事件（spinWheel 函数内）
    // if (window.clarityInitialized && window.clarity && typeof window.clarity === 'function') {
    //   window.clarity('trackEvent', 'wheel_spin', {
    //     spin_count: spinCount + 1,
    //     target_sector: spinCount === 0 ? 1 : 4
    //   });
    // }
  };

  // 模态框关闭处理
  const closeWelcomeModal = () => {
    setShowWelcomeModal(false);
    spinWheel();
  };

  const closeTryAgainModal = () => {
    setShowTryAgainModal(false);
    spinWheel();
  };

  const trackConversionEvent = () => {
  // 发送GA转化事件
  ReactGA.event({
    category: 'Reward',
    action: 'Claim',
    label: 'Walmart_Giftcard',
    value: 1,
    // 关联click_id参数
    customDimensions: {
      cd1: clickId // 需要在GA后台提前配置自定义维度cd1为click_id
    }
  });

  // // 发送 Clarity 自定义事件
  // if (window.clarityInitialized && window.clarity && typeof window.clarity === 'function') {
  //   window.clarity('trackEvent', 'reward_claimed', {
  //     click_id: clickId || 'unknown',
  //     timestamp: new Date().toISOString()
  //   });
  // }

  if (!clickId) return; // 确保click_id存在

  // 获取当前时间戳（精确到秒）
  const timestamp = Math.floor(Date.now() / 1000);

  // 构建打点URL
  const trackingUrl = `https://pb.taurusx.com/general/event?click_id=${clickId}&event_name=add_to_cart&event_time=${timestamp}`;

  // 使用Image对象发送GET请求
  const img = new Image();
  img.src = trackingUrl;

  // 可选：添加请求状态监听
  img.onload = () => console.log('Tracking request sent successfully');
  img.onerror = () => console.error('Tracking request failed');

  
  };

  return (
    <div className="App">
      {/* 页面标题 */}
      <h1>🎯 Spin & Win Big!</h1>

      {/* 倒计时区域 */}
      <div className="countdown">
        ⏰ Hurry! Only <span className="timer-value">{remainingTime}</span> seconds left to spin!
      </div>

      {/* 转盘容器 */}
      <div className="wheel-container">
        {/* 指针 */}
        <div className="wheel-pointer"></div>
        
        {/* 转盘 */}
        <div 
          className="wheel"
          ref={wheelRef}
          style={{ 
            backgroundImage: `url(${prizewheelBg})`,
            transform: `rotate(${rotation}deg)`,
            transition: 'transform 4s cubic-bezier(0.2, 0.8, 0.2, 1)',
            willChange: 'transform'
          }}
        ></div>
      </div>

      {/* 旋转按钮 */}
      <button 
        className="spin-btn"
        onClick={spinWheel}
        disabled={isSpinning || remainingTime <= 0 || showWelcomeModal || showTryAgainModal || showWinModal}
      >
        {isSpinning ? 'Spinning...' : 'SPIN THE WHEEL! 🎡'}
      </button>

      {/* 滚动消息区域 */}
      <div className="messages">
        <div className="message-scroll">
          <p>🎉 Jason from NYC just won a $50 gift card!</p>
          <p>🎁 Emily from LA got a free T-shirt!</p>
          <p>👏 Mike from Chicago unlocked VIP access!</p>
          <p>🔥 Sarah from Miami won 30% off!</p>
        </div>
      </div>

      {/* 欢迎模态框 */}
      {showWelcomeModal && (
        <div className="modal-overlay">
          <div className="modal">
            <h2>🎁 Special Offer!</h2>
            <p>Spin the wheel for a chance to win big! Don't miss out on this amazing opportunity!</p>
            <button className="modal-btn" onClick={closeWelcomeModal}>Try My Luck! 🎯</button>
          </div>
        </div>
      )}

      {/* 再来一次模态框 */}
      {showTryAgainModal && (
        <div className="modal-overlay">
          <div className="modal">
            <h2>😮 Almost There!</h2>
            <p>So close! Give it another spin - your prize might be just one spin away!</p>
            <button className="modal-btn" onClick={closeTryAgainModal}>Spin Again! 🎡</button>
          </div>
        </div>
      )}

      {/* 中奖模态框 */}
      {showWinModal && (
        <div className="modal-overlay">
          <div className="modal">
            <h2>🎉 Congratulations!</h2>
            <img src={walmartImage} alt="Walmart Prize" className="prize-image" />
            <p>You've won a  Big Free Gift! Click below to claim your prize!</p>
            <button 
              className="modal-btn claim-btn"
              onClick={() => {
                try {
                  // 1. 先发送打点请求
                  trackConversionEvent();
                } catch (error) {
                  console.error('打点请求出错:', error);
                }
                // 2. 确保跳转执行
                window.location.href=`https://www.hjqqot8trk.com/LR9KH/21WL22Z/?sub1=${clickId || 'unknown'}`;
              }}
            >
              Claim Now! 💰
            </button>
          </div>
        </div>
      )}
    </div>
  );
}

export default App;