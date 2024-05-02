import React from "react";
import {
  GridList as AriaGridList,
  GridListItem as AriaGridListItem,
  Button,
  Checkbox,
  GridListItemProps,
  GridListProps,
  composeRenderProps,
} from "react-aria-components";
import { tv } from "tailwind-variants";
import { useKeys } from "../../uses/useKeys";
import { twMerge } from "tailwind-merge";

export function GridList<T extends object>({
  children,
  ...props
}: GridListProps<T>) {
  return (
    <>
      <AriaGridList
        {...props}
        className={composeTailwindRenderProps(
          props.className,
          "overflow-auto relative border dark:border-zinc-600 rounded-lg"
        )}
      >
        {children}
      </AriaGridList>
    </>
  );
}

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

export function GridListItem({ children, ...props }: GridListItemProps) {
  const textValue = typeof children === "string" ? children : undefined;
  return (
    <AriaGridListItem textValue={textValue} {...props} className={itemStyles}>
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
    </AriaGridListItem>
  );
}

export function composeTailwindRenderProps<T>(
  className: string | ((v: T) => string) | undefined,
  tw: string
): string | ((v: T) => string) {
  return composeRenderProps(className, (className) => twMerge(tw, className));
}

export const Sidebar = (args: any) => {
  const keys = useKeys();

  return (
    <GridList aria-label="Ice cream flavors" {...args}>
      <GridListItem id="chocolate">Chocolate</GridListItem>
      <GridListItem id="mint">Mint</GridListItem>
      <GridListItem id="strawberry">Strawberry</GridListItem>
      <GridListItem id="vanilla">Vanilla</GridListItem>
    </GridList>
    // <GridList
    //   selectionMode={"multiple"}
    //   className={composeTailwindRenderProps(
    //     "",
    //     "overflow-auto relative border dark:border-zinc-600 rounded-lg"
    //   )}
    // >
    //   {keys.slice(0, 15).map((key) => (
    //     <SidebarCard key={key} name={key} />
    //   ))}
    // </GridList>
  );
};

Sidebar.args = {
  onAction: null,
  selectionMode: "multiple",
  allowsDragging: true,
};
