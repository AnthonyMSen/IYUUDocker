#每12小时15分钟时更新IYUU
15 */12 * * * cd /IYUU && git fetch --all && git reset --hard origin/master >> /logs/update_iyuu.log 2>&1

#每小时45分运行IYUU
45 * * * * php /IYUU/iyuu.php >> /logs/run_iyuu.log 2>&1
