import React, { useEffect } from "react";

import { usePropNames } from "../../uses/usePropNames";
import { selectedVarsVar } from "../../apollo/vars";
import { useReactiveVar } from "@apollo/client";
import { SidebarCard } from "../molecules/SidebarCard";

export const GridLiGridListstItem = () => {
  return <>test</>;
};

export const GridListItem = () => {
  return <>hoge</>;
};

export const Sidebar = () => {
  const propNames = usePropNames();
  const selectedVars = useReactiveVar(selectedVarsVar);

  useEffect(() => {
    console.log("selectedVars", selectedVars);
  }, [selectedVars]);

  return (
    <div
      style={{
        display: "flex",
        flexDirection: "column",
        height: "100%",
        gap: "0.5rem",
      }}
    >
      {propNames.map((propName) => (
        <SidebarCard propName={propName} />
      ))}
    </div>
  );
};

Sidebar.args = {
  onAction: null,
  selectionMode: "multiple",
  allowsDragging: true,
};
