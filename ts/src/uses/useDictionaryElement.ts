import { useReactiveVar } from "@apollo/client";
import { dictionaryVar } from "../apollo/vars";

export const useDictionaryElement = (name: string) => {
  const data = useReactiveVar(dictionaryVar);
  return data.find((item) => item.name === name) || null;
};
