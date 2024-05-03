import { useReactiveVar } from "@apollo/client";
import { selectedVarsVar } from "../../apollo/vars";
import { SingleTable } from "../molecules/SingleTable";
import { Crosstab } from "../molecules/Crosstab";

export const TableGrid = () => {
  const propNames = useReactiveVar(selectedVarsVar);
  // get last two selected vars
  const lastTwo = propNames.slice(-2);

  return (
    <div
      style={{
        display: "grid",
        gridTemplateRows: "50% 50%",
        gridTemplateAreas: `
          "single"
          "crosstab"
        `,
        gap: "0.5rem",
        width: "100%",
        height: "100%",
      }}
    >
      <div
        style={{
          display: "flex",
          gridArea: "single",
          gap: "0.5rem",
          width: "100%",
          height: "100%",
        }}
      >
        {propNames.map((propName) => {
          console.log(propName);
          return <SingleTable name={propName} />;
        })}
      </div>
      {propNames.length >= 2 && (
        <div
          style={{
            display: "flex",
            gridArea: "crosstab",
            gap: "0.5rem",
            width: "100%",
            height: "100%",
          }}
        >
          <Crosstab nameX={lastTwo[0]} nameY={lastTwo[1]} />
        </div>
      )}
    </div>
  );
};
