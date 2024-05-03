import React, { useEffect, useRef } from "react";
import { useTable } from "../../uses/useTable";
import {
  DataEditor,
  GridCell,
  GridCellKind,
  GridColumn,
  Item,
} from "@glideapps/glide-data-grid";
import { Text, Button, Field, Input } from "@fluentui/react-components";
import { selectedVarsVar } from "../../apollo/vars";
import { useDictionaryElement } from "../../uses/useDictionaryElement";
import { Control } from "../../types";

type Props = {
  name: string;
};

export const SingleTable = (props: Props) => {
  const dictionaryElement = useDictionaryElement(props.name);
  const [control, setControl] = React.useState<Control>({
    min: undefined,
    binWidth: undefined,
  });
  const distribution = useTable(props.name, control);

  const timer = useRef<NodeJS.Timeout | null>(null);

  useEffect(() => {
    if (timer.current) clearTimeout(timer.current);
    if (!control) return;
    timer.current = setTimeout(() => {
      if (Number.isNaN(control!.min) && Number.isNaN(control!.binWidth)) return;
    }, 500);
  }, [control]);

  const columns: GridColumn[] = [
    {
      title: props.name,
      id: "propName",
    },
    {
      title: "Count",
      id: "count",
    },
  ];

  const getCellContent = (cell: Item): GridCell => {
    const [col, row] = cell;
    if (col === 0) {
      return {
        kind: GridCellKind.Text,
        allowOverlay: false,
        displayData: distribution[row].propName,
        data: distribution[row].propName,
      };
    } else {
      return {
        kind: GridCellKind.Number,
        allowOverlay: false,
        displayData: distribution[row].value.toString(),
        data: distribution[row].value,
      };
    }
  };

  return (
    <div
      style={{
        height: "100%",
        display: "flex",
        flexDirection: "column",
        gap: "0.5rem",
      }}
    >
      <DataEditor
        getCellContent={getCellContent}
        columns={columns}
        rows={distribution.length}
        height={"100%"}
        getCellsForSelection={true}
      />
      {dictionaryElement?.type === "numeric" && (
        <>
          <div
            style={{
              display: "flex",
              gap: "0.5rem",
              justifyContent: "space-between",
              alignItems: "center",
            }}
          >
            <Text>Min</Text>
            <Input
              type={"number"}
              value={control.min?.toString() || ""}
              onChange={(e) => {
                setControl({ ...control, min: Number(e.target.value) });
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
            <Text>Bin Width</Text>
            <Input
              type={"number"}
              value={control.binWidth?.toString() || ""}
              onChange={(e) => {
                setControl({ ...control, binWidth: Number(e.target.value) });
              }}
            />
          </div>
        </>
      )}
      <Button
        appearance={"outline"}
        onClick={() => {
          selectedVarsVar(
            selectedVarsVar().filter((item) => item !== props.name)
          );
        }}
      >
        Remove
      </Button>
    </div>
  );
};
