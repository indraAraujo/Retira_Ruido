
function bitonicMerge(a, low, cnt, dir) {
	if (cnt > 1) {
	  var k = parseInt(cnt / 2);
	  for (var i = low; i < low + k; i++) {
		if ((a[i] > a[i + k] && dir === 1) ||
		  (a[i] < a[i + k] && dir === 0)) {
		  // Swapping elements
		  var temp = a[i];
		  a[i] = a[i + k];
		  a[i + k] = temp;
		}
	  }
	  bitonicMerge(a, low, k, dir);
	  bitonicMerge(a, low + k, k, dir);
	}
  }

  function bitonicSort(a, low, cnt, dir) {
	if (cnt > 1) {
	  var k = parseInt(cnt / 2);
  
	  bitonicSort(a, low, k, 1);
  
	  bitonicSort(a, low + k, k, 0);
  
	  bitonicMerge(a, low, cnt, dir);
	}
  }
  
  let matrix = [
	[3, 1, 10, 12],
	[5, 9, 6, 30],
	[8, 43, 21, 65],
	[23, 45, 7, 12]
  ];
  
  let mediana;
  
  function getMediana(arr) {
	let mediana;
	const tamanho = arr.length;
	if (tamanho % 2 == 1) {
	  mediana = arr[((tamanho + 1) / 2) - 1];
	} else {
	  mediana = (arr[(tamanho / 2)] + arr[((tamanho / 2) - 1)]) / 2;
	}
  
	return mediana;
  }
  
  for (let i = 0; i < 4; i++) {
	bitonicSort(matrix[i], 0, matrix[i].length, 1);
  };
  let vetor = [].concat(...matrix);
  bitonicSort(vetor, 0, vetor.length, 1);
  console.log(matrix);
  console.log(vetor)
  mediana = getMediana(vetor);
  console.log(mediana)
  