const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#201b16", /* black   */
  [1] = "#88775A", /* red     */
  [2] = "#7B8271", /* green   */
  [3] = "#A99045", /* yellow  */
  [4] = "#91896F", /* blue    */
  [5] = "#7E8883", /* magenta */
  [6] = "#9B9D94", /* cyan    */
  [7] = "#c7c6c4", /* white   */

  /* 8 bright colors */
  [8]  = "#75685f",  /* black   */
  [9]  = "#88775A",  /* red     */
  [10] = "#7B8271", /* green   */
  [11] = "#A99045", /* yellow  */
  [12] = "#91896F", /* blue    */
  [13] = "#7E8883", /* magenta */
  [14] = "#9B9D94", /* cyan    */
  [15] = "#c7c6c4", /* white   */

  /* special colors */
  [256] = "#201b16", /* background */
  [257] = "#c7c6c4", /* foreground */
  [258] = "#c7c6c4",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
