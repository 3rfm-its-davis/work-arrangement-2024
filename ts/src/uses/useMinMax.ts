import { useReactiveVar } from "@apollo/client";
import { dataVar } from "../apollo/vars";
import { useDictionaryElement } from "./useDictionaryElement";

export const useMinMax = (propName: string) => {
  const type = useDictionaryElement(propName)?.type;

  const data = useReactiveVar(dataVar).map((item) => item[propName]);

  if (type !== "numeric") {
    return { min: undefined, max: undefined };
  }
  const min = Math.min(...(data as number[]));
  const max = Math.max(...(data as number[]));
  return { min, max };
};
