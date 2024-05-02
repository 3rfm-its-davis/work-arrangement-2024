import { Flex, Grid, View } from "@adobe/react-spectrum";
import { Sidebar } from "./components/organisms/Sidebar";
import "./App.css";
import { Header } from "./components/organisms/Header";

export const App = () => {
  return (
    <Grid
      areas={["header  header", "sidebar content", "footer  footer"]}
      columns={["1fr", "3fr"]}
      rows={["size-600", "calc(100vh - size-1200 - 1rem)", "size-600"]}
      gap={"size-100"}
    >
      <View gridArea={"header"}>
        <Header />
      </View>
      <View height={"100%"} gridArea={"sidebar"} overflow={"auto"}>
        <Sidebar />
      </View>
      <View gridArea={"content"}>main</View>
      <View gridArea={"footer"}>footer</View>
    </Grid>
  );
};
