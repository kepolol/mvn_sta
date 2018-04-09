;+
;PROCEDURE:to_mathlab
;PURPOSE:
; Файл для записи tplot переменных в ASCii формат (*.txt) !!!!!помесячно!!!!!
; Для использования необходимо заменить mvn_sta_l2_tplot.pro на модернизированный
; На данный момент дублирует данные из последнего существующего дня в несуществующие
; Запись происходит с первого дня месяца
; 
;-
pro to_mathlab
  dprint, 'начало временного интервала'
  yy = ''
  read, yy, prompt = ('yyyy:  ')
  mo = ''
  read, mo, prompt = ('MM:  ')
;  day_int = ''
  read, day_int, prompt = ('day_interval:  ')
  day=['01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31','32']
  t=day_int
  for n = 0, t-1 do begin
    t1=yy+'-'+mo+'-'+day[n]
    t2=yy+'-'+mo+'-'+day[n+1]
    timespan, [t1, t2]
    mvn_swe_load_l2, /spec
    mvn_lpw_load_l2, ['lpnt'],trange=[t1,t2], /noTPLOT
    tplot_ascii, 'mvn_lpw_lp_ne_l2', fname = yy+mo+day[n],dir = 'C:\Users\STU\Desktop\1\mvn_lpw_lp_ne_l2'
    DEL_DATA, 'mvn_lpw_lp_ne_l2'
; обработка исключения    
    CATCH, Error_status
    IF Error_status NE 0 THEN BEGIN
      catch, /cancel
      continue
    ENDIF
;конец обработки    
    mvn_swe_n1d
    tplot_ascii, 'mvn_swe_spec_dens', fname = yy+mo+day[n],dir = 'C:\Users\STU\Desktop\1\mvn_swe_spec_dens'
    data=read_ascii('C:\Users\STU\Desktop\1\mvn_swe_spec_dens\'+yy+mo+day[n]+'_mvn_swe_spec_dens.txt',num_records=1, header=d,data_start=1)
    if strcmp(t1, d, 10) eq 0 then begin
      FILE_DELETE,'C:\Users\STU\Desktop\1\mvn_swe_spec_dens\'+yy+mo+day[n]+'_mvn_swe_spec_dens.txt'
    endif
  endfor
end

