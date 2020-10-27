#     Copyright 2020 Langston Howley

#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at

#        http://www.apache.org/licenses/LICENSE-2.0

#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.

from astroquery.simbad import Simbad
import astropy.coordinates as coord
import astropy.units as u
import sys, getopt


if __name__ == "__main__":
    STAR = ''

    opts, args = getopt.getopt(sys.argv[1:],'s:')
    for opt,arg in opts:
        if(opt == '-s'):
            STAR = arg  
    
    table = Simbad.query_object(STAR)

    star_id = table['MAIN_ID'][0]
    ra = table['RA'][0]
    dec = table['DEC'][0]

    print ("Object ID: {}\n\tRA: {}\n\tDEC: {}".format(
        star_id,
        ra, dec
    ))




#print(Simbad.query_objectids("Polaris"))