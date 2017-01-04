fpga_device "xc6vlx240t-1-ff1156"

fpga_file "resources/v6_gtx.vhd"
fpga_file "resources/mmcm.vhd"
fpga_file "wrapper.vhdl"
fpga_file "../../../hdl_utils/vhdl/verif/verif_pkg.vhdl" -lib "utils"
fpga_file "../../../hdl_utils/vhdl/verif/loopcheck.vhdl" -lib "utils"
fpga_file "../../../hdl_utils/vhdl/sync/sync_pkg.vhdl"   -lib "utils"
fpga_file "../../../hdl_utils/vhdl/sync/boundary.vhdl"   -lib "utils"
fpga_file "../../../hdl_utils/vhdl/verif/transloop.vhdl" -lib "utils"
fpga_file "top.vhdl" -top "Top"
fpga_file "ml605.ucf"