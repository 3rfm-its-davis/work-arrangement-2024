import { Heading, View, Text, Flex, ActionButton } from "@adobe/react-spectrum";
import { useDictionaryElement } from "../../uses/useDictionaryElement";
import Filter from "@spectrum-icons/workflow/Filter";
import {
  Button,
  Checkbox,
  GridListItem,
  GridListItemProps,
} from "react-aria-components";
import { tv } from "tailwind-variants";

type Props = {
  name: string;
};

const itemStyles = tv({
  base: "relative flex gap-3 cursor-default select-none py-2 px-3 text-sm text-gray-900 dark:text-zinc-200 border-y dark:border-y-zinc-700 border-transparent first:border-t-0 last:border-b-0 first:rounded-t-md last:rounded-b-md -mb-px last:mb-0 -outline-offset-2",
  variants: {
    isSelected: {
      false: "hover:bg-gray-100 dark:hover:bg-zinc-700/60",
      true: "bg-blue-100 dark:bg-blue-700/30 hover:bg-blue-200 dark:hover:bg-blue-700/40 border-y-blue-200 dark:border-y-blue-900 z-20",
    },
    isDisabled: {
      true: "text-slate-300 dark:text-zinc-600 forced-colors:text-[GrayText] z-10",
    },
  },
});

export const SidebarCard = ({
  children,
  ...props
}: GridListItemProps & Props) => {
  const dictionaryElement = useDictionaryElement(props.name);
  const textValue = typeof children === "string" ? children : "hoge";
  // const question = useQuestion(props.name);
  // const type = useColumnType(props.name);
  // const selected = selectedVarsVar().includes(props.name);

  // get the mean of the numeric value
  // const mean =
  //   dataVar()
  //     .map((item) => item)
  //     .reduce((acc, item) => acc + (item[props.name] as number), 0) /
  //   dataVar().length;

  // const onClick = () => {
  //   selectedVarsVar(_.xor(selectedVarsVar(), [props.name]));
  // };

  return (
    <GridListItem textValue={textValue} {...props} className={itemStyles}>
      {({ selectionMode, selectionBehavior, allowsDragging }) => (
        <>
          {/* Add elements for drag and drop and selection. */}
          {allowsDragging && <Button slot="drag">≡</Button>}
          {selectionMode === "multiple" && selectionBehavior === "toggle" && (
            <Checkbox slot="selection" />
          )}
          {children}
        </>
      )}
    </GridListItem>
  );

  return (
    <GridListItem id={props.name} textValue={textValue} className={itemStyles}>
      {dictionaryElement ? (
        <View
          borderColor={"gray-600"}
          borderRadius={"medium"}
          borderWidth={"thin"}
          paddingX={"size-150"}
          paddingY={"size-100"}
        >
          <Flex
            direction={"row"}
            alignItems={"center"}
            height={"size-600"}
            gap={"size-50"}
          >
            <Heading
              level={2}
              marginY={0}
              UNSAFE_style={{
                color:
                  dictionaryElement.type.slice(0, 1) === "n"
                    ? "var(--spectrum-global-color-orange-700)"
                    : dictionaryElement.type.slice(0, 1) === "h"
                    ? "var(--spectrum-global-color-blue-700)"
                    : "var(--spectrum-global-color-green-700)",
              }}
            >
              {dictionaryElement.type.slice(0, 1).toUpperCase()}
            </Heading>
            <View>
              <Heading level={4} margin={0}>
                {dictionaryElement.name}
              </Heading>
              <Text>{dictionaryElement.question}</Text>
            </View>
            <ActionButton
              marginStart={"auto"}
              onPress={() => {
                console.log("Filter button pressed");
              }}
            >
              <Filter />
            </ActionButton>
          </Flex>
        </View>
      ) : null}
    </GridListItem>
  );
};
