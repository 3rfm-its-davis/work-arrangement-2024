import { useReactiveVar } from "@apollo/client";
import { dataVar } from "../apollo/vars";
import { useDictionaryElement } from "./useDictionaryElement";
import { Control } from "../types";
import { getBins } from "../utils/getBins";
import { useMinMax } from "./useMinMax";

export const useCrosstab = (
  propNameX: string,
  propNameY: string,
  controlX: Control,
  controlY: Control
) => {
  const data = useReactiveVar(dataVar);
  const dictionaryElementX = useDictionaryElement(propNameX);
  const dictionaryElementY = useDictionaryElement(propNameY);
  const { min: minX, max: maxX } = useMinMax(propNameX);
  const { min: minY, max: maxY } = useMinMax(propNameY);

  if (
    !dictionaryElementX ||
    !dictionaryElementY ||
    controlX.binWidth === 0 ||
    controlY.binWidth === 0
  ) {
    return {
      table: [
        {
          x: "undefined",
          y: "undefined",
          count: data.length,
        },
      ],
      xArray: ["undefined"],
      yArray: ["undefined"],
    };
  }

  let dataTransformed = data;

  // if (controlX.binWidth && controlY.binWidth) {
  //   const binsX = getBins(
  //     controlX.min !== undefined ? controlX.min : minX!,
  //     maxX!,
  //     controlX.binWidth
  //   );

  //   const binsY = getBins(
  //     controlY.min !== undefined ? controlY.min : minY!,
  //     maxY!,
  //     controlY.binWidth
  //   );

  //   console.log(binsX, binsY);

  //   const table = binsX.reduce(
  //     (
  //       acc: {
  //         x: string;
  //         y: string;
  //         count: number;
  //       }[],
  //       itemX
  //     ) => {
  //       binsY.forEach((itemY) => {
  //         const count = data.filter((item) => {
  //           const x = Number(item[propNameX]);
  //           const y = Number(item[propNameY]);
  //           return (
  //             x >= itemX.min && x < itemX.max && y >= itemY.min && y < itemY.max
  //           );
  //         }).length;
  //         acc.push({
  //           x: itemX.label,
  //           y: itemY.label,
  //           count,
  //         });
  //       });
  //       return acc;
  //     },
  //     []
  //   );

  //   return {
  //     table,
  //     xArray: Array.from(new Set(table.map((item) => item.x))),
  //     yArray: Array.from(new Set(table.map((item) => item.y))),
  //   };
  // }

  if (controlX.binWidth) {
    const binsX = getBins(
      controlX.min !== undefined ? controlX.min : minX!,
      maxX!,
      controlX.binWidth
    );

    dataTransformed = dataTransformed.map((item) => {
      const value = Number(item[propNameX]);
      const bin = binsX.find((bin) => value >= bin.min && value < bin.max);
      return { ...item, [propNameX]: bin?.label ?? "undefined" };
    });
  }

  if (controlY.binWidth) {
    const binsY = getBins(
      controlY.min !== undefined ? controlY.min : minY!,
      maxY!,
      controlY.binWidth
    );

    dataTransformed = dataTransformed.map((item) => {
      const value = Number(item[propNameY]);
      const bin = binsY.find((bin) => value >= bin.min && value < bin.max);
      return { ...item, [propNameY]: bin?.label ?? "undefined" };
    });
  }

  let table = dataTransformed.reduce(
    (
      acc: {
        x: string;
        y: string;
        count: number;
      }[],
      item
    ) => {
      const valueX = item[propNameX]?.toString() || "undefined";
      const valueY = item[propNameY]?.toString() || "undefined";
      const index = acc.findIndex(
        (item) => item.x === valueX && item.y === valueY
      );
      if (index !== -1) {
        acc[index].count = acc[index].count + 1;
      } else {
        acc.push({ x: valueX, y: valueY, count: 1 });
      }
      return acc;
    },
    []
  );

  if (dictionaryElementY.type === "numeric") {
    table = table.sort((a, b) => Number(a.y) - Number(b.y));
  }

  if (dictionaryElementX.type === "numeric") {
    table = table.sort((a, b) => Number(a.x) - Number(b.x));
  }

  if (dictionaryElementY.type === "haven_labelled") {
    table = table
      .sort((a, b) => Number(a.y) - Number(b.y))
      .map((item) => {
        return {
          ...item,
          y:
            dictionaryElementY.labels?.find(
              (label) => label.value === Number(item.y)
            )?.label ?? item.y,
        };
      });
  }

  if (dictionaryElementX.type === "haven_labelled") {
    table = table
      .sort((a, b) => Number(a.x) - Number(b.x))
      .map((item) => {
        return {
          ...item,
          x:
            dictionaryElementX.labels?.find(
              (label) => label.value === Number(item.x)
            )?.label ?? item.x,
        };
      });
  }

  console.log(table);

  return {
    table,
    xArray: Array.from(new Set(table.map((item) => item.x))),
    yArray: Array.from(new Set(table.map((item) => item.y))),
  };
};
