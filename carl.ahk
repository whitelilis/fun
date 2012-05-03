
current_use = 1
save1 = "O"
save2 = "O"

;1急速冷却[QQQ] [Y] 将目标冻结，冻结期间目标受伤害会受眩晕和额外伤害。 
;2幽灵漫步[QQW] [V] 隐身，降低自己和周围敌方的移动速度。 
;3寒冰之墙[QQE] [G] 在面前造出一个冰墙，使在冰墙内的单位大幅度减速。 
;4灵动迅捷[WWW] [Z] 将汹涌的能量灌注进一个友方单位，提升40%至160%的攻击速度。 
;5强袭飓风[WWQ] [X] 释放一股向前移动的龙卷风，将途经的敌方单位卷至半空。 
;6电磁脉冲[WWE] [C] 在目标地点积聚电磁能量，在4至2秒内爆炸，造成伤害并耗魔。 
;7阳炎冲击[EEE] [T] 召唤能量从天而降，在1.7秒后造成伤害。施法距离全屏幕。 
;8熔炉精灵[EEQ] [F] 制造2个火元素，有法球伤害，被火元素打到的单位每次减1点护甲。 
;9混沌陨石[EEW] [D] 召唤陨石，向前滚动500至1550的距离对敌方造成伤害。 
;0超震声波[QWE] [B] 给予一条线上的所有人的打击，先减少280点血然后是退后。


gen_status(save_number, s1, s2){
	;msgbox "invoke display"
	if(save_number = 0){
		return "no save used"
	} else if (save_number = 1){
		return  save_number . " : " . s1
	} else if (save_number = 2){
		return save_number . " : " . s1 . " " . s2
	} else {
		return "something wrong"
	}
}

display_status(save_number, s1, s2){
	
	send ,{Enter} 
	send % gen_status(save_number, s1, s2)
	send ,{Enter}
}

toggle_save(byref save_number, byref s1, byref s2){
	if(save_number = 1){
		save_number = 2
		s2 = %s1%
		s1 = "O"
		display_status(save_number, s1, s2)
	}else{
		save_number = 1
		s1 = "O"
		s2 = "O"
		display_status(save_number, s1, s2)
	}
}

gen_string(byref s1, byref s2, byref save_number, in){
	;msgbox % "c faint :" . s1 . ":" . s2 . ":" .  save_number . ":" . in . ":"
	;default 3 w
	common_pre = www

	;define basic key map
	if ( in = "y"){
		pre = qqq
	} else if(in = "v"){
		pre = qqw
	} else if(in = "g"){
		pre = qqe
	} else if(in = "z"){
		pre = www
	} else if(in = "x"){
		pre = wwq
	} else if(in = "c"){
		pre = wwe
	} else if(in = "t"){
		pre = eee
	} else if(in = "f"){
		pre = eeq
	} else if(in = "d"){
		pre = eew
	} else if(in = "b"){
		pre = qwe
	} else {
		pre = ""
	}

	; default no save for use		
	if (save_number = 0){
		return in
	
	; 1 save for use 
	} else if(save_number = 1){
		if ( s1 = in){
			;msgbox "s1 save"
			return in
		}else{
			s1 = %in%
			;msgbox % "s1:in is #" . s1 . ":" . in  
	 		return pre . "r" . common_pre . in
		}
	; 2 save for use
	} else if(save_number = 2){
		if ( s1 = in  or  s2 = in){
			return in
		} else {
			s2 = %s1%
			s1 = %in%
			return pre . "r" . common_pre . in
		}		
	} else{
		msgbox % "c faint :" . s1 . ":" . s2 . ":" .  save_number . ":" . in . ":"
		return in
	}
}



;yvgzxctfdb  for hero Carl to use

$y::send % gen_string(save1, save2, current_use, "y")
$v::send % gen_string(save1, save2, current_use, "v")
$g::send % gen_string(save1, save2, current_use, "g")
$z::send % gen_string(save1, save2, current_use, "z")
$x::send % gen_string(save1, save2, current_use, "x")
$c::send % gen_string(save1, save2, current_use, "c")
$t::send % gen_string(save1, save2, current_use, "t")
$f::send % gen_string(save1, save2, current_use, "f")
$d::send % gen_string(save1, save2, current_use, "d")
$b::send % gen_string(save1, save2, current_use, "b")


; for help and toggle
*F5::display_status(current_use, save1, save2)
*F8::toggle_save(current_use, save1, save2)


; q for 1 shortcut to numpad7
$q::send ,{Numpad7}



; for single use, only this, notic the begin $ and last {v}, used to avoid infinite loop
; $v::SendInput qqqrwww{v}