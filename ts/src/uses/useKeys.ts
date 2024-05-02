import { useReactiveVar } from "@apollo/client";
import { dictionaryVar } from "../apollo/vars";

export const useKeys = () => {
  const data = useReactiveVar(dictionaryVar);
  return data.map((item) => item.name);
};
