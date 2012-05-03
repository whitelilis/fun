
current_use = 1
save1 = "O"
save2 = "O"

;1������ȴ[QQQ] [Y] ��Ŀ�궳�ᣬ�����ڼ�Ŀ�����˺�����ѣ�κͶ����˺��� 
;2��������[QQW] [V] ���������Լ�����Χ�з����ƶ��ٶȡ� 
;3����֮ǽ[QQE] [G] ����ǰ���һ����ǽ��ʹ�ڱ�ǽ�ڵĵ�λ����ȼ��١� 
;4�鶯Ѹ��[WWW] [Z] ����ӿ��������ע��һ���ѷ���λ������40%��160%�Ĺ����ٶȡ� 
;5ǿϮ쫷�[WWQ] [X] �ͷ�һ����ǰ�ƶ�������磬��;���ĵз���λ������ա� 
;6�������[WWE] [C] ��Ŀ��ص���۵����������4��2���ڱ�ը������˺�����ħ�� 
;7���׳��[EEE] [T] �ٻ����������������1.7�������˺���ʩ������ȫ��Ļ�� 
;8��¯����[EEQ] [F] ����2����Ԫ�أ��з����˺�������Ԫ�ش򵽵ĵ�λÿ�μ�1�㻤�ס� 
;9������ʯ[EEW] [D] �ٻ���ʯ����ǰ����500��1550�ľ���Եз�����˺��� 
;0��������[QWE] [B] ����һ�����ϵ������˵Ĵ�����ȼ���280��ѪȻ�����˺�


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