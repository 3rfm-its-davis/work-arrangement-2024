export const getBins = (min: number, max: number, binWidth: number) => {
  const bins = [];
  let i = min;

  while (i <= max) {
    bins.push({
      min: i,
      max: i + binWidth,
      label: `[${i}, ${i + binWidth})`,
    });
    i += binWidth;
  }

  return bins;
};
