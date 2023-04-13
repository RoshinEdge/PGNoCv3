#проект создается как постсинтезируемый (позволяет использовать EDIF файлы как исходник
set_property design_mode GateLvl [current_fileset]
#добавляем в проект ранее созданный файл top.edif
add_files -norecurse C:/Users/RomashihinMU/Desktop/top.edif
#добавляем данный файл с копированием в директорию проекта
import_files -force –norecurse
#делаем файл top.edif файлом верхнего уровня
set_property top_file C:/Users/RomashihinMU/Desktop/test_cnt.edif [current_fileset]
link_design -name netlist_1

#импортировать файл физических ограничений, описывающий выводы
import_files -fileset constrs_1 –force C:/Users/RomashihinMU/Desktop/Mode_separ_fpga/test_auto/pinout.xdc

#сделать данный файл ограничений приоритетным
set_property target_constrs_file C:/Users/RomashihinMU/Desktop/Mode_separ_fpga/test_auto/pinout.xdc [current_fileset -constrset]
save_constraints -force

#прочесть файл ограничений
read_xdc C:/Users/RomashihinMU/Desktop/Mode_separ_fpga/test_auto/pinout.xdc

#запуск имплементации, а затем создание прошивки (bitstream)
launch_runs impl_1 -to_step write_bitstream -jobs 12
