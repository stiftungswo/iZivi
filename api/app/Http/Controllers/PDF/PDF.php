<?php
/**
 * Created by PhpStorm.
 * User: Simon Rösch
 * Date: 7/25/17
 * Time: 11:34 AM
 */

namespace App\Http\Controllers\PDF;


use FPDI;

abstract class PDF
{
    protected $pdf;

    public function __construct($landscape=false)
    {
        if($landscape){
            $this->pdf = new utfFPDI('L');
        }else{
            $this->pdf = new utfFPDI();
        }
    }

    protected abstract function render();

    public function createPDF(){

        $this->render();

        $DIR_TEMP = sys_get_temp_dir();
        $file=basename(tempnam($DIR_TEMP, 'tmp'));
        //Save PDF to file
        $this->pdf->Output($file, 'F');
        return $file;
    }

    /*
     * Helpers
     */

    /**
     * Converts a unix timestamp to a iso date (YYYY-MM-DD).
     * @param int $timestamp A unix timestamp
     */
    protected function timestamp2iso( $timestamp ) {
        $isoDate= date("Y-m-d",$timestamp);
        return $isoDate;
    }

    /**
     * Converts a unix timestamp to a european date (DD.MM.YYYY)
     */
    protected function timestamp2europeDate( $timestamp ) {
        $europeanDate = date("d.m.Y", $timestamp);
        return $europeanDate;
    }

    protected function getGermanMonth($timestamp ){
        $month_str = "";
        switch(date("m", $timestamp)) {
            case  1: $month_str = "Januar"; break;
            case  2: $month_str = "Februar"; break;
            case  3: $month_str = "M&auml;rz"; break;
            case  4: $month_str = "April"; break;
            case  5: $month_str = "Mai"; break;
            case  6: $month_str = "Juni"; break;
            case  7: $month_str = "Juli"; break;
            case  8: $month_str = "August"; break;
            case  9: $month_str = "September"; break;
            case 10: $month_str = "Oktober"; break;
            case 11: $month_str = "November"; break;
            case 12: $month_str = "Dezember"; break;
        }
        return $month_str;
    }

    public static function getRoundedRappen($val) {
        return number_format(round($val * 20) / 20, 2, '.', '');
    }

}

class utfFPDI extends FPDI
{

    function Cell($w, $h = 0, $txt = "", $border = 0, $ln = 0, $align = '', $fill = false, $link = '')
    {
        if (!empty($txt)) {
            if (mb_detect_encoding($txt, 'UTF-8', false)) {
                $txt = iconv('UTF-8', 'windows-1252', $txt);

            }
        }
        parent::Cell($w, $h, $txt, $border, $ln, $align, $fill, $link);

    }

}