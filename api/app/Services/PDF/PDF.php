<?php
/**
 * Created by PhpStorm.
 * User: Simon Rösch
 * Date: 7/25/17
 * Time: 11:34 AM
 */

namespace App\Services\PDF;

use setasign\Fpdi\Fpdi;

abstract class PDF
{
    protected $pdf;

    public function __construct($landscape = false)
    {
        if ($landscape) {
            $this->pdf = new UtfFPDI('L');
        } else {
            $this->pdf = new UtfFPDI();
        }
    }

    abstract protected function render();

    public function createPDF()
    {

        $this->render();

        $DIR_TEMP = sys_get_temp_dir();
        $file=tempnam($DIR_TEMP, 'tmp');
        //Save PDF to file
        $this->pdf->Output($file, 'F');
        return $file;
    }

    /*
     * Helpers
     */

    // TODO check how we can optimize those ugly helpers
    /**
     * Converts a unix timestamp to a iso date (YYYY-MM-DD).
     *
     * @param  int $timestamp A unix timestamp
     * @return false|string
     */
    protected function timestamp2iso($timestamp)
    {
        $isoDate= date("Y-m-d", $timestamp);
        return $isoDate;
    }

    /**
     * Converts a unix timestamp to a european date (DD.MM.YYYY)
     */
    protected function timestamp2europeDate($timestamp)
    {
        $europeanDate = date("d.m.Y", $timestamp);
        return $europeanDate;
    }

    protected function getGermanDate($timestamp)
    {

        $month_str = "";
        switch (date("m", $timestamp)) {
            case 1:
                $month_str = "Jan.";
                break;
            case 2:
                $month_str = "Feb.";
                break;
            case 3:
                $month_str = "März";
                break;
            case 4:
                $month_str = "Apr.";
                break;
            case 5:
                $month_str = "Mai";
                break;
            case 6:
                $month_str = "Juni";
                break;
            case 7:
                $month_str = "Juli";
                break;
            case 8:
                $month_str = "Aug.";
                break;
            case 9:
                $month_str = "Sep.";
                break;
            case 10:
                $month_str = "Okt.";
                break;
            case 11:
                $month_str = "Nov.";
                break;
            case 12:
                $month_str = "Dez.";
                break;
        }

        return date("d.", $timestamp).' '.$month_str.' '.date("Y", $timestamp);
    }

    protected function getGermanMonth($timestamp)
    {
        $month_str = "";
        switch ($timestamp) {
            case 1:
                $month_str = "Januar";
                break;
            case 2:
                $month_str = "Februar";
                break;
            case 3:
                $month_str = "März";
                break;
            case 4:
                $month_str = "April";
                break;
            case 5:
                $month_str = "Mai";
                break;
            case 6:
                $month_str = "Juni";
                break;
            case 7:
                $month_str = "Juli";
                break;
            case 8:
                $month_str = "August";
                break;
            case 9:
                $month_str = "September";
                break;
            case 10:
                $month_str = "Oktober";
                break;
            case 11:
                $month_str = "November";
                break;
            case 12:
                $month_str = "Dezember";
                break;
        }
        return $month_str;
    }

    public static function getRoundedRappen($val)
    {
        return number_format(round($val * 20) / 20, 2, '.', '');
    }
}
