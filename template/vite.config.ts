import { defineConfig } from "vite";

export default defineConfig({
  define: {
    __BUILD_TIMESTAMP__: Math.floor(Date.now() / 1000),
  },
  server: {
    port: 5173,
    proxy: {
      "/api": {
        target: "http://localhost:8080",
        changeOrigin: true,
      },
    },
  },
  build: {
    outDir: "../backend/src/main/resources/META-INF/resources",
    emptyOutDir: true,
  },
});
