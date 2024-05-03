import { useReactiveVar } from "@apollo/client";
import { dataVar } from "../apollo/vars";
import { useDictionaryElement } from "./useDictionaryElement";
import { Control } from "../types";
import { useMinMax } from "./useMinMax";
import { getBins } from "../utils/getBins";

export const useTable = (propName: string, control: Control) => {
  const data = useReactiveVar(dataVar);
  const dictionaryElement = useDictionaryElement(propName);
  const { min, max } = useMinMax(propName);

  if (!dictionaryElement || control.binWidth === 0) {
    return [];
  }

  if (control.binWidth) {
    const bins = getBins(
      control.min !== undefined ? control.min : min!,
      max!,
      control.binWidth
    );

    const table = bins.map((item) => {
      const count = data.filter((item2, index, array) =>
        index === array.length - 1
          ? Number(item2[propName]) >= item.min
          : Number(item2[propName]) >= item.min &&
            Number(item2[propName]) < item.max
      ).length;
      return {
        propName: item.label,
        value: count,
      };
    });

    return table;
  }

  const counts = data.reduce(
    (
      acc: {
        [propName: string]: number;
      },
      item
    ) => {
      const value = item[propName]?.toString();
      if (!value) return acc;
      if (acc[value]) {
        acc[value] = acc[value] + 1;
      } else {
        acc[value] = 1;
      }
      return acc;
    },
    {} as { [propName: string]: number }
  );

  const table = Object.entries(counts).map(([propName, value]) => ({
    propName,
    value,
  }));

  if (dictionaryElement.type === "numeric") {
    return table.sort((a, b) => Number(a.propName) - Number(b.propName));
  }

  if (dictionaryElement.type === "haven_labelled") {
    return table
      .sort((a, b) => Number(a.propName) - Number(b.propName))
      .map(({ propName, value }) => ({
        propName:
          dictionaryElement.labels?.find(
            (label) => label.value === Number(propName)
          )?.label ?? propName,
        value,
      }));
  }

  return table;
};
