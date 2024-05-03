import ReactDOM from "react-dom/client";
import { App } from "./App.tsx";
import "./index.css";
import { FluentProvider, webLightTheme } from "@fluentui/react-components";
import "@glideapps/glide-data-grid/dist/index.css";

ReactDOM.createRoot(document.getElementById("root")!).render(
  <FluentProvider theme={webLightTheme}>
    <App />
  </FluentProvider>
);
