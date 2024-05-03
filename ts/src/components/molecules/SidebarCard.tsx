import { Card, CardHeader, Text } from "@fluentui/react-components";
import { useReactiveVar } from "@apollo/client";
import { selectedVarsVar } from "../../apollo/vars";

type Props = {
  propName: string;
};

export const SidebarCard = (props: Props) => {
  const selectedVars = useReactiveVar(selectedVarsVar);

  return (
    <Card
      key={props.propName}
      style={{
        minHeight: "4rem",
        display: "flex",
        flexDirection: "column",
        justifyContent: "center",
        cursor: "pointer",
        backgroundColor: selectedVars.includes(props.propName)
          ? "lightblue"
          : "white",
        transition: "background-color 0.3s",
      }}
      onClick={(e) => {
        console.log((e.target as HTMLElement)?.textContent);
        if (selectedVars.includes(props.propName)) {
          selectedVarsVar(selectedVars.filter((v) => v !== props.propName));
        } else {
          selectedVarsVar([...selectedVars, props.propName]);
        }
      }}
    >
      <CardHeader header={<Text weight="semibold">{props.propName}</Text>} />
    </Card>
  );
};
