import { makeVar } from "@apollo/client";
import jsonData from "../data/data.json";
import dictionary from "../data/dictionary.json";

type Dictionary = {
  [key: string]: {
    type: string;
    question: string | null;
    labels?: {
      [key: string]: number;
    };
  };
};

type DictionaryFormatted = {
  name: string;
  type: string;
  question?: string;
  labels?: {
    label: string;
    value: number;
  }[];
}[];

export const data = jsonData as { [key: string]: string | number }[];
const dictionaryFormatted = Object.entries(dictionary as Dictionary).map(
  ([name, value]) => ({
    name,
    ...value,
    question: value.question === null ? undefined : value.question,
    labels: value.labels
      ? Object.entries(value.labels).map(([label, value]) => ({ label, value }))
      : undefined,
  })
);

export const dataVar = makeVar(data);
export const dictionaryVar = makeVar<DictionaryFormatted>(dictionaryFormatted);
export const filterOutConditionsVar = makeVar<
  {
    name: string;
    type: "numeric" | "label";
    outs: number[];
  }[]
>([]);
export const selectedVarsVar = makeVar<string[]>([]);
