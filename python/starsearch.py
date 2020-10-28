from astroquery.simbad import Simbad
import astropy.coordinates as coord
import astropy.units as u
import sys, getopt


if __name__ == "__main__":
    pass
    simbad = Simbad()

    STAR = sys.argv[-1]

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