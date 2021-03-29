#######################################################
# Jpeg の GPS 位置情報を削除する
#######################################################
function RemoveGPSExif( $JpegFile ){

	# 拡張子チェック
	$FileName = Split-Path $JpegFile -Leaf
	if( (($FileName -split "\.")[1] -ne "jpg" ) -and (($FileName -split "\.")[1] -ne "jpeg" )){
		return
	}

	# フルパスにする
	$JpegFileFullName = Convert-Path $JpegFile -ErrorAction SilentlyContinue
	if( $JpegFileFullName -eq $null ){
		echo "$JpegFile not convert full path."
		return
	}

	# 存在確認
	if( -not ( Test-Path $JpegFileFullName )){
		echo "$JpegFile not found"
		return
	}

	# テンポラリファイル名
	$TempFile = $JpegFileFullName + ".tmp"

	# アセンブリロード
	Add-Type -AssemblyName System.Drawing

	# Jpeg 読み込み
	$bmp = [System.Drawing.Bitmap]::new($JpegFileFullName)

	# GPS Exif を潰す(Exif 2.3 で 0 - 31 まで使っている)
	for( $Index = 0; $Index -le 31; $Index++){
		try{
			[void]$bmp.GetPropertyItem($Index)
		}
		catch{
			continue
		}

		$bmp.RemovePropertyItem($Index)
	}

	# ファイル出力
	$bmp.Save($TempFile, [System.Drawing.Imaging.ImageFormat]::Jpeg )
	$bmp.Dispose()

	# オリジナルとテンポラリファイルを入れ替える
	$Org_Path = Split-Path -Path $JpegFileFullName
	$Org_FileName = Split-Path -Leaf $JpegFileFullName
	$New_FileName = $Org_FileName.Split(".")[0] + "-ORG." + $Org_FileName.Split(".")[1]
	ren $JpegFileFullName $New_FileName
	ren $TempFile $JpegFileFullName
}
