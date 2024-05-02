import { View, Heading, Flex } from "@adobe/react-spectrum";

export const Header = () => {
  return (
    <View paddingStart={"size-200"} backgroundColor={"blue-400"}>
      <Flex direction={"row"} alignItems={"center"} height={"size-600"}>
        <Heading level={2} UNSAFE_style={{ margin: 0 }}>
          Data Explorer
        </Heading>
      </Flex>
    </View>
  );
};
