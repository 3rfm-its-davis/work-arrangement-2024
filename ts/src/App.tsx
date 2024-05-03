import { Sidebar } from "./components/organisms/Sidebar";
import "./App.css";
import { Header } from "./components/organisms/Header";
import { TableGrid } from "./components/organisms/TableGrid";

export const App = () => {
  return (
    <div
      style={{
        display: "grid",
        gridTemplateColumns: "20rem calc(100% - 20rem)",
        gridTemplateAreas: `
          "header header"
          "sidebar content"
          "footer footer"
        `,
        height: "100vh",
      }}
    >
      <div style={{ gridArea: "header", height: "3rem" }}>
        <Header />
      </div>
      <div style={{ gridArea: "sidebar", overflowY: "scroll", height: "100%" }}>
        <Sidebar />
      </div>
      <div style={{ gridArea: "content", width: "100%" }}>
        <TableGrid />
      </div>
      <div style={{ gridArea: "footer", height: "3rem" }}>Footer</div>
    </div>
  );
};
