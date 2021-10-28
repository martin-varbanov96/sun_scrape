#!/bin/bash

# #                                                                    
# #mmm    mmmm         mmmmm   mmm   m mm    mmm    mmmm   mmm    m mm 
# #" "#  #" "#         # # #  "   #  #"  #  "   #  #" "#  #"  #   #"  "
# #   #  #   #         # # #  m"""#  #   #  m"""#  #   #  #""""   #    
# ##m#"  "#m##         # # #  "mm"#  #   #  "mm"#  "#m"#  "#mm"   #    
#            #                                      m  #               
#            "                                       ""              
# 
cd bq_manager
zip -u insert_bq *
cd ..

cd $SUN_SCRAPE_ROOT/cloud_functions/most_read_article_cf
zip -u most_read_article_cf *
cd $SUN_SCRAPE_ROOT
