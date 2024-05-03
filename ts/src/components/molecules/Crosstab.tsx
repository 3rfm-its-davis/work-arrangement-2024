import React from "react";
import { useTable } from "../../uses/useTable";
import {
  DataEditor,
  GridCell,
  GridCellKind,
  GridColumn,
  Item,
} from "@glideapps/glide-data-grid";
import { useCrosstab } from "../../uses/useCrossTab";
import { Control } from "../../types";
import { useDictionaryElement } from "../../uses/useDictionaryElement";
import { Input, Text } from "@fluentui/react-components";

type Props = {
  nameX: string;
  nameY: string;
};

export const Crosstab = (props: Props) => {
  const dictionaryElementX = useDictionaryElement(props.nameX);
  const [controlX, setControlX] = React.useState<Control>({
    min: undefined,
    binWidth: undefined,
  });
  const dictionaryElementY = useDictionaryElement(props.nameY);
  const [controlY, setControlY] = React.useState<Control>({
    min: undefined,
    binWidth: undefined,
  });
  const distribution = useCrosstab(
    props.nameX,
    props.nameY,
    controlX,
    controlY
  );

  const columns: GridColumn[] = [
    {
      title: `${props.nameY} \\ ${props.nameX}`,
      id: "firstColumn",
    },
    ...Array.from(distribution.xArray).map((x) => {
      return {
        title: x,
        id: x,
      };
    }),
  ];

  const getCellContent = (cell: Item): GridCell => {
    const [col, row] = cell;
    if (col === 0) {
      return {
        kind: GridCellKind.Text,
        allowOverlay: false,
        displayData: distribution.yArray[row] || "N/A",
        data: distribution.yArray[row] || "N/A",
      };
    } else {
      return {
        kind: GridCellKind.Number,
        allowOverlay: false,
        displayData:
          distribution.table
            .find(
              (item) =>
                item.x === distribution.xArray[col - 1] &&
                item.y === distribution.yArray[row]
            )
            ?.count.toString() || "0",
        data:
          distribution.table.find(
            (item) =>
              item.x === distribution.xArray[col - 1] &&
              item.y === distribution.yArray[row]
          )?.count || 0,
      };
    }
  };

  return (
    <div
      style={{
        width: "100%",
        height: "100%",
        display: "flex",
        flexDirection: "column",
        gap: "0.5rem",
      }}
    >
      <DataEditor
        getCellContent={getCellContent}
        columns={columns}
        rows={distribution.yArray.length}
        width={"100%"}
        height={"100%"}
        getCellsForSelection={true}
      />
      <div
        style={{
          display: "flex",
          gap: "0.5rem",
          justifyContent: "space-between",
          alignItems: "center",
        }}
      >
        {dictionaryElementX?.type === "numeric" && (
          <div
            style={{
              display: "flex",
              gap: "0.5rem",
              justifyContent: "space-between",
              alignItems: "center",
            }}
          >
            <div
              style={{
                display: "flex",
                gap: "0.5rem",
                justifyContent: "space-between",
                alignItems: "center",
              }}
            >
              <Text>X Min</Text>
              <Input
                type={"number"}
                value={controlX.min?.toString() || ""}
                onChange={(e) => {
                  setControlX({ ...controlX, min: Number(e.target.value) });
                }}
              />
            </div>
            <div
              style={{
                display: "flex",
                gap: "0.5rem",
                alignItems: "center",
                justifyContent: "space-between",
              }}
            >
              <Text>X Bin Width</Text>
              <Input
                type={"number"}
                value={controlX.binWidth?.toString() || ""}
                onChange={(e) => {
                  setControlX({
                    ...controlX,
                    binWidth: Number(e.target.value),
                  });
                }}
              />
            </div>
          </div>
        )}
        {dictionaryElementY?.type === "numeric" && (
          <div
            style={{
              display: "flex",
              gap: "0.5rem",
              justifyContent: "space-between",
              alignItems: "center",
            }}
          >
            <div
              style={{
                display: "flex",
                gap: "0.5rem",
                justifyContent: "space-between",
                alignItems: "center",
              }}
            >
              <Text>Y Min</Text>
              <Input
                type={"number"}
                value={controlY.min?.toString() || ""}
                onChange={(e) => {
                  setControlY({ ...controlY, min: Number(e.target.value) });
                }}
              />
            </div>
            <div
              style={{
                display: "flex",
                gap: "0.5rem",
                alignItems: "center",
                justifyContent: "space-between",
              }}
            >
              <Text>Y Bin Width</Text>
              <Input
                type={"number"}
                value={controlY.binWidth?.toString() || ""}
                onChange={(e) => {
                  setControlY({
                    ...controlY,
                    binWidth: Number(e.target.value),
                  });
                }}
              />
            </div>
          </div>
        )}
      </div>
    </div>
  );
};
