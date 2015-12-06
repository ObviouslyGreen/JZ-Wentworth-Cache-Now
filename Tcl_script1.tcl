set_global_assignment -name PHYSICAL_SYNTHESIS_REGISTER_RETIMING ON         
set_global_assignment -name PLACEMENT_EFFORT_MULTIPLIER 1.5                 
set_global_assignment -name ROUTER_LCELL_INSERTION_AND_LOGIC_DUPLICATION ON 
set_global_assignment -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON      
set_global_assignment -name ROUTER_TIMING_OPTIMIZATION_LEVEL MAXIMUM        
set_global_assignment -name PRE_MAPPING_RESYNTHESIS ON                      
set_global_assignment -name PHYSICAL_SYNTHESIS_COMBO_LOGIC ON               
set_global_assignment -name PHYSICAL_SYNTHESIS_EFFORT normal                
set_global assignment -name FITTER_EFFORT "STANDARD FIT"                    
set_global_assignment -name ENABLE_BENEFICIAL_SKEW_OPTIMIZATION OFF 