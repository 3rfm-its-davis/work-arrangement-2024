import ReactDOM from "react-dom/client";
import { App } from "./App.tsx";
import "./index.css";
import { Provider, defaultTheme } from "";

ReactDOM.createRoot(document.getElementById("root")!).render(
  <Provider theme={defaultTheme}>
    <App />
  </Provider>
);
