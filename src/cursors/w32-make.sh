#!/bin/sh

THEME=Suru
DIR="../../.."

# $@ is for the caller to be able to supply arguments to anicursorgen (-s, in particular)

GEN=../anicursorgen.py\ "$@"

# enter cursors folder
cd bitmaps

if [ ! -d "$DIR/$THEME/cursors" ]; then
	mkdir -p $DIR/$THEME/cursors
fi

${GEN} --no-shadows tcross$s.in $DIR/$THEME/cursors/tcross.cur
${GEN} all-scroll$s.in $DIR/$THEME/cursors/all-scroll.cur
# ${GEN} based_arrow_down$s.in $DIR/$THEME/cursors/based_arrow_down.cur
# ${GEN} based_arrow_up$s.in $DIR/$THEME/cursors/based_arrow_up.cur
${GEN} bd_double_arrow$s.in $DIR/$THEME/cursors/bd_double_arrow.cur
${GEN} bottom_left_corner$s.in $DIR/$THEME/cursors/bottom_left_corner.cur
${GEN} bottom_right_corner$s.in $DIR/$THEME/cursors/bottom_right_corner.cur
${GEN} bottom_side$s.in $DIR/$THEME/cursors/bottom_side.cur
${GEN} bottom_tee$s.in $DIR/$THEME/cursors/bottom_tee.cur
# ${GEN} center_ptr$s.in $DIR/$THEME/cursors/center_ptr.cur
${GEN} circle$s.in $DIR/$THEME/cursors/circle.cur
${GEN} context-menu$s.in $DIR/$THEME/cursors/context-menu.cur
${GEN} copy$s.in $DIR/$THEME/cursors/copy.cur
${GEN} cross$s.in $DIR/$THEME/cursors/cross.cur
${GEN} crossed_circle$s.in $DIR/$THEME/cursors/crossed_circle.cur
${GEN} crosshair$s.in $DIR/$THEME/cursors/cell.cur
${GEN} dnd-ask$s.in $DIR/$THEME/cursors/dnd-ask.cur
${GEN} dnd-copy$s.in $DIR/$THEME/cursors/dnd-copy.cur
${GEN} dnd-link$s.in $DIR/$THEME/cursors/dnd-link.cur
${GEN} dnd-move$s.in $DIR/$THEME/cursors/dnd-move.cur
${GEN} dnd-no-drop$s.in $DIR/$THEME/cursors/dnd-no-drop.cur
${GEN} dnd-none$s.in $DIR/$THEME/cursors/dnd-none.cur
${GEN} dotbox$s.in $DIR/$THEME/cursors/dotbox.cur
${GEN} fd_double_arrow$s.in $DIR/$THEME/cursors/fd_double_arrow.cur
${GEN} grabbing$s.in $DIR/$THEME/cursors/grabbing.cur
${GEN} hand1$s.in $DIR/$THEME/cursors/hand1.cur
${GEN} hand2$s.in $DIR/$THEME/cursors/hand2.cur
${GEN} left_ptr$s.in $DIR/$THEME/cursors/left_ptr.cur
${GEN} left_ptr_watch$s.in $DIR/$THEME/cursors/left_ptr_watch.ani
${GEN} left_side$s.in $DIR/$THEME/cursors/left_side.cur
${GEN} left_tee$s.in $DIR/$THEME/cursors/left_tee.cur
${GEN} link$s.in $DIR/$THEME/cursors/link.cur
${GEN} ll_angle$s.in $DIR/$THEME/cursors/ll_angle.cur
${GEN} lr_angle$s.in $DIR/$THEME/cursors/lr_angle.cur
${GEN} move$s.in $DIR/$THEME/cursors/move.cur
${GEN} pencil$s.in $DIR/$THEME/cursors/pencil.cur
${GEN} plus$s.in $DIR/$THEME/cursors/plus.cur
${GEN} pointer-move$s.in $DIR/$THEME/cursors/pointer-move.cur
${GEN} question_arrow$s.in $DIR/$THEME/cursors/question_arrow.cur
${GEN} right_ptr$s.in $DIR/$THEME/cursors/right_ptr.cur
${GEN} right_side$s.in $DIR/$THEME/cursors/right_side.cur
${GEN} right_tee$s.in $DIR/$THEME/cursors/right_tee.cur
${GEN} sb_down_arrow$s.in $DIR/$THEME/cursors/sb_down_arrow.cur
${GEN} sb_h_double_arrow$s.in $DIR/$THEME/cursors/sb_h_double_arrow.cur
${GEN} sb_left_arrow$s.in $DIR/$THEME/cursors/sb_left_arrow.cur
${GEN} sb_right_arrow$s.in $DIR/$THEME/cursors/sb_right_arrow.cur
${GEN} sb_up_arrow$s.in $DIR/$THEME/cursors/sb_up_arrow.cur
${GEN} sb_v_double_arrow$s.in $DIR/$THEME/cursors/sb_v_double_arrow.cur
${GEN} top_left_corner$s.in $DIR/$THEME/cursors/top_left_corner.cur
${GEN} top_right_corner$s.in $DIR/$THEME/cursors/top_right_corner.cur
${GEN} top_side$s.in $DIR/$THEME/cursors/top_side.cur
${GEN} top_tee$s.in $DIR/$THEME/cursors/top_tee.cur
${GEN} ul_angle$s.in $DIR/$THEME/cursors/ul_angle.cur
${GEN} ur_angle$s.in $DIR/$THEME/cursors/ur_angle.cur
${GEN} vertical-text$s.in $DIR/$THEME/cursors/vertical-text.cur
${GEN} watch$s.in $DIR/$THEME/cursors/watch.ani
${GEN} X_cursor$s.in $DIR/$THEME/cursors/X_cursor.cur
${GEN} xterm$s.in $DIR/$THEME/cursors/xterm.cur
${GEN} zoom-in$s.in $DIR/$THEME/cursors/zoom-in.cur
${GEN} zoom-out$s.in $DIR/$THEME/cursors/zoom-out.cur

# go back up
cd ..