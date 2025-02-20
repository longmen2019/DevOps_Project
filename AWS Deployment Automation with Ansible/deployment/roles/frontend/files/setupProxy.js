const { createProxyMiddleware } = require('http-proxy-middleware');

module.exports = app => {
  app.use(
    "/reverser",
    createProxyMiddleware({
      target: "http://10.0.1.205:5000",
      changeOrigin: true
    })
  );

  app.use(
    "/summation",
    createProxyMiddleware({
      target: "http://10.0.1.205:5000",
      changeOrigin: true
    })
  );
};

