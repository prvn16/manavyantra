/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_sobel_info.c
 *
 * Code generation for function '_coder_sobel_info'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "sobel.h"
#include "_coder_sobel_info.h"

/* Function Definitions */
mxArray *emlrtMexFcnProperties(void)
{
  mxArray *xResult;
  mxArray *xEntryPoints;
  const char * fldNames[4] = { "Name", "NumberOfInputs", "NumberOfOutputs",
    "ConstantInputs" };

  mxArray *xInputs;
  const char * b_fldNames[4] = { "Version", "ResolvedFunctions", "EntryPoints",
    "CoverageInfo" };

  xEntryPoints = emlrtCreateStructMatrix(1, 1, 4, fldNames);
  xInputs = emlrtCreateLogicalMatrix(1, 2);
  emlrtSetField(xEntryPoints, 0, "Name", emlrtMxCreateString("sobel"));
  emlrtSetField(xEntryPoints, 0, "NumberOfInputs", emlrtMxCreateDoubleScalar(2.0));
  emlrtSetField(xEntryPoints, 0, "NumberOfOutputs", emlrtMxCreateDoubleScalar
                (1.0));
  emlrtSetField(xEntryPoints, 0, "ConstantInputs", xInputs);
  xResult = emlrtCreateStructMatrix(1, 1, 4, b_fldNames);
  emlrtSetField(xResult, 0, "Version", emlrtMxCreateString(
    "9.3.0.713579 (R2017b)"));
  emlrtSetField(xResult, 0, "ResolvedFunctions", (mxArray *)
                emlrtMexFcnResolvedFunctionsInfo());
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}

const mxArray *emlrtMexFcnResolvedFunctionsInfo(void)
{
  const mxArray *nameCaptureInfo;
  const char * data[52] = {
    "789ced5d4d6c2bc971e6ee7aed5d248e99acb3bbfef7738cc5da9b3c49fc1125dbb14552439114ffc41f89d4f32e351c0ec911e78f33438ad425f2c18673b0b1"
    "3190c0872c9ca31120808104f106310219f16191531038393846e0203012e410e4621f924332e470f438b36c699ed86c72c86ac0ee372a4e7f3db5d555d5d5d5",
    "dd9ea712e9a73c1ecfafe9ff1bd6cf7dfc69cfb0bcdf6314efb87eda632d76fa53e3fad4f66c96673defb1bc67d2ff785c3392a8b17dcd78e03991cd74851aab"
    "e80f222db037cdd425811369512b0e64d6a3b0aac4f7d8fa88d2e078b6c8096c4a9a788873fa83109b20dd3c0c49c37f475b2cd32e74058fd2521f77979f7cf0",
    "4cf0e7db88ef7f8f43fef810fcf1dae88fa8d7a39fdbd0fb257715714355980d46aab34a9d15a42a5b6fb2d53aabb18cc6493a51aab1fc43c1dacf33443fdeeb"
    "b09ff6da2ccf7b9e9b78fae0de5d784ef9f20c02cf3ba6d03c3faa71e1bd0f89675078a9c931347f83f7dd19f128249e95fe28912a8ffed3e714a9a9d0c22787",
    "32aa6ea4c3c55438b291f76d6e856a1b9a24f135a9bfc10afc06cfd536045ae3e9da8624ab1b3a9f46a2404e0eaebe77f2a17f0c93953bd272be38bc3ea23da7"
    "72f72202cf6ba357424a874966eabd08d7a77dc1145d9102f5e8e37ee4eec0b9ab1f1ec433a9f661fc5a8b55de3e75a3c7af10ed39e5d32710785e1b7d64cd1e",
    "72bad157449a7fc8a9912ec76b095137fbacc2310bd3f36fcf885746e259e94f2c27c3ffbd36e2dac66b26db36ec6c7b2810d4fbdfffc54f40efbb5def677b9d"
    "68b811efed148f02038612445fec948f83de5f0fbdffea1e2e797b0981e7b5d16d7a5fffecac121607d8f4fd7b6ccf8ffb615098163d9c54dee07d6f46bc9ced",
    "d963fb9d49c7a3ef4d7691d4f39e377ef4c23f819e9f131e293def0b3435a1291dfbf6452ec9eea7597f3cdc8dad8e9e87713cbdff16b9bbdac316afb9cbafe6"
    "54b6d39df0ab67c57bafedf9319e41a94bdd1acfe2938743249e953e8bdd6779fd1f1b634e8d037804fdf7b7c17f77bf5e2f943a5d2d93383e2ee50b47db4a27",
    "1c0fb27404f4fafa8ce361f9e48d5e9711ed39e517eabf8fd756eb2ca88ebfb8ca480abb283d7f3d23deeb483c2b7d281fb9d9044456b81eadb11b76d6918ed7"
    "7fe5ef5e057fdeed7a9fdaaeed66ce63b9c149ac51689c50d9d056a5bd42719b6bc4fb30aead655ef19c9711785e1bdd16cf1169a5c9894cab3dab3db017543f",
    "cc824b6ebe7c079e497f227f416dd10a5b3756f0c7ffffae29e10de70c0782a03d78e173f91f833d98131e297b30e85f2476e958a319dc64b29454388f754317"
    "14d883651dd728b9702a87a87c99e7c7f5cb96bf7e6acfa85f19d7bf8d2d0ef42ca21fde31a5c14bd230e0eed63850028967a5cf367f6c74c58d11a7cc342e92",
    "faea87a557200ee476fdbfd309658b1d7e3fd88eb48a470705adb3bfcf407c7f9dc6b167320e748568cfad793c4faaf7218f677a6d16c8e3218307793c78da07"
    "fd3fbdff56b9fb3436fdff11049ed746b7e97f95a1795a79687afdb3fbfdf6e2340e34abfe2fdd8167d2f1e8ffd70cbe4dc80e41fdffa790bfef7efd5f6b6de7",
    "ca22afd50b924075c5b8bf46459207a0ffd755ffbf8968cf29bf3e83c0f3dae8f67c4e59e6078591328b75c5d1feb48498e369c6dcc2876b9dfa0377f4cfa437"
    "c6bda8b668b1ae4f104cfc7766c4afdd816fd231e58b21d9ba807d7fd1af0661fdd8edf622953c642a9ddc6eb8920e28aa4fe67cbd50727f75ec058cefe9dfe5",
    "4c1e1faedc3c625171249847cc0bcf28eb8207f3083cedcf3a8fc8d99e3db6df997477ef13d8bfd1ff5f47b4e7945fbf85c0f3dae836fdcf48a2aa6524b1c089"
    "4d9ed524719f330ce1a2f6055fcf883797fc03a4dc4c631fe9bc22d837364f3c52f6201a2a098c9ff58981a37c9eeac8ca36d3f0af903d70cb793ea8788953f9",
    "7adaf66c16335fc81a47fff49e51bf422c4f48d758bd21afdc9a2744629f499dd6e8618471c42bf2fbc57ee514e23eaed7e7fde4899f0fa78f12f9d2a6b2cb48"
    "697a9789ad903e87713cbdff56b9fb28ec13b827de5cfd79d827b034fa98341eec13c0d3fe35e27da77cac22daf7dae818f5ff035a5559452b7465595234b63e",
    "3adb946cbce700f246c7bf81bcd1e9b559206f940c1ee48de2691fe603d3fb6f95bbcf623b3fc2695ecef05b75775766554df171756cfafe49cf7fbb9e11ef0d"
    "249e953ed33e735340cc9de636e60d4586a0bc7ce3c5e7210ee476bdbfbbc53395149fef45b548ed446c07c4935a6c85f27fae11efc3b8b696799d23f4bcedd9",
    "63fb9d49d7bf9467c5a6d61a3f2fca0eccea2764907856fa2c7e82ceaba1b4dcb08cac7c5c7d13f4befbf57e6727d86f0a3b74534c46769add4a7437d4955628"
    "fe03e3787aff21fe6f1488ff4fff1e07fa1fe2ff73c483f83f9ef6af11ef3be56305d1bed746c7abff1f0cddd127f283f1cae1e788e5f970aa225d78dcebe793",
    "d947689c27ab736a11fb08fff7bf20aeef7a3d1f4a857ce1dd72ecf442cb6c463b1daddff21d419ecf3a8d63cfe47e60149e537e3d677bf6dcfccea070aafead"
    "0ad777ab5e4f21f1ac741cf260708a783efeff805e77bf5eef694c5ae1a49210f45d8aede3d4ee45ba1c8773de6edacbd99e3db6df99749cf93bb1522a4554ee",
    "ae6558afbd27de1aaeebc07aed1cf160bd164ffbb3eafdb5c8d3c1787f17e938cd6a9edb0c719a55c583380d9ef6611c4fefffaac46948eb7588d360c71b9575"
    "c183380d9ef6af11efcfe37e2e5c719a513d3c15859569851ea9a5059dafd0de1b557b6d6c7938f7bc7f5d56a4baca5ddebddf6c59edc1dce27d53f75b99ec82",
    "7d56ab8247ca1eb43b854c584ed4b25c42ce945abdd2ce6647837b7ae73f8e6fb10785709a222b771d88dbdf130fe2f673c71b9575c183b83d9ef6af11efbb75"
    "1e7086e82fde38beb468bfdf3827986a82dfefc8ef37d945d4ef7febad9f82dfef76fdbf99b90809454e383de4f275ea709f29341a03f0fbd7681cebe52a8dcd",
    "ef7fbfedd963fb9d49e754d13812461b9e26e4de75dc2c12cf4abf977fd0e0fa6c5d9674f1d8b0f04b77f409cac79fc1b9f9eed7f307fef6a0d069727cb4186d"
    "e73b9166b15da256c8cf073d3fbdff283d8fc2c3b78edbe0f4e94dcbad7a3d89c4b3d267d7eb069f16708f0ee8f539e2cdaad77f1381e7b5d17b1d96927b8cba",
    "5bbef04b524e2d6cf92ba79ed5d1ebee3aeff0b15e7fd0e014556b7064f3eecf6ef4fb15a23da77cfb3802cf6ba3eb6ca8ea9f5f6d480a2f497255eab14a8397"
    "2eaa4c8b65dab3fbf5f682ea8f5970c5fdce6ccf763c933e531e8f2146b7f08f683ce7073f7f16e2f9cb6a0f9cfaf9ea21d5a7f62f2f73c9be2f90f66d468fc2",
    "5b9b2b747ec27f20de77cac7af21daf7dae8f31ed70f6eff41b5c5f232ab9096d7036cf383bbd65f877eefb05ef03a0327d6d97e42d46efaf1dd19fb11bba31f"
    "261dc7bc81f07aefdb90e7e37efb5018c89c10ece44fb6b85a3d90383dcaa5b77a2b140782f16b2d5679db5c99383fe9f31720ce8f1d6f54d6050fe2fc78da07",
    "ffdfda5fbcf29ac0e6ffdf15afd73f5da0fbeeb507735d1fb0eef31a718afcfac0d5db2f417ea7ebed81d2d994cf39351016b6732131572bfb0f8fd515caef01"
    "7b60ed2fdef562b2f68013c11e38b3079cb8007bf0d7600fdc6f0f9a742594f59f643aa15a588b06e96c800dacd2790eb05e3cbd368b45fe7e76864dbf3f69bc",
    "7f56bc27cd0782b8a0b5405c9f0c1ec4f5f1b4bfb47afd967d5c9c7a20772971b883ab4e360fe8f13e5eb2ebaa4db9fbb0c96a8f3fdbb5f93fa777e099f44709"
    "2cd7a7e88cdbb0306e01f9a0e2b742e0dfbbdd0e6433476a325ff605bac1623f2cca72e7229b85737d6eda5bcbfdbc397ce731ff2a02cf6ba30fbf59acb6f569",
    "0ecb0f9f89cd33446d6712ef7a46bc47483c2b1dfbb90e26f3889fe37ab5f99741b003cb6a079cee0bd0922c972a3407e17ca1c89f37123b0797e98107ecc0fa"
    "8eeb61f161db1ff011049ed746b7e55bd2e2403784314ee43476445f543c68d6f964118967a5e389134eb28df8799ffffa17600f96d61e389d1714292a264653",
    "9bbe78259f0b44dafdb63f978cae8e3d80f13cbd368b55fefc04f701abfaa44765ddba0f3883c4b3d267ba6f53e7d0d04d307945f8def4ef30bf84f8bfdbf57b"
    "90cfc72fa4f4ce81bf146f8698e865329f28ac509e0fe8f7e9b559acf2b78d2dfeef74be69f3f36fee0a5e54fc7f69f5fe547931ef59262a276ffce805f0eb97",
    "55ef3b1d77c5d4f1e9ae502f2be19340a8bfe53f163633871ed0fbeba9f7bf40f47c9fe157ba55bf93bca7a5b11079b882bc9e39e291f2eb29fe3053496ef953"
    "8d6657a0b9cd56b31267e3a0dfd75dbfcf2a7f2f23f0bc36bacdafef85793eab84c501aef564a7f70434ba22a37192586dd1629d67b1c9cfd11df8261d8ffcdc",
    "b06f01f7b85d7df1ab10c777bd3dd889ee5eaa977c2ada928f8f1a85622458dada5aa1fc9e7710ef3be5631dd1bed746c73e9e1f34785a3b66194d52cc3f4e7e"
    "d719a2df78e5b18c6d7d17ce7fbb1dcfa4c3f96ff7c533cabae0c1f96f78da07fb30fdbb1cc9e3dea9ebe24366fba4d77d213e841bcf28eb8207f1213cedc338",
    "9ede7fd4fdec5788f69cf2eb13083caf8d6e3f47538d74395e4b8819e3f432d7e67592ddff6d671bdcdbbb2a78c4f67bf53ad17023dedb291e05060c2588bed8"
    "290ffa7fcdf4ffabd8fcfa671178de31855339b1e1595cdefeacf29040e259e938e441e7d422e2fce0d7cf118f583e673fcdc7dabdfa7962bbdc4fd6155f402c",
    "6caf509c1fc6f1f4fe835f0f7efd6ddf017efd62f1c0afc7d33ef8f5d3fbbf38bf5ea4450ff8f54ee441e714f8f52b86472a5fbf13ee6685c0a01cd8cc2bbe6e"
    "748bdded09190fe8f5f519c7c3027e3df8f5d67e835fbf583cf0ebf1b47f8d787f1e7977733a97e741ac944a9195c3c7e7eccb88f670e7d30f3f596dd132ab6a",
    "8a8f9bfd9ccea76cbf7b37fef473f7af67c47b038967a563979709e611deb7fb8d17e11c7ed7db81dd2d9ea9a4f87c2faa456a27623b209ed4622b745ef335e2"
    "7d37d98142384d1195c3ab24d8817be2811d983bdea8ac0b1ed8013cedcf9aafcf22daf7dae8f3b403c33d3aa3339c3da4e5b1842d4ef431049ed746b7c5896a",
    "3cad3ed45a0aabb6247eb8376251f661d638d10912cf4ac713277a6dc8b78d1bbe91bdc7f711f5b7102772bb5d48d78f77b3999dee412c59cf74a46caeb47fe9"
    "877d5c4b6f17ae10fd762a8f28bdf8fcb8fee4e41ff7bebc67fca36ad47f7266d4d775d807ec213f0f857dc0eed3e7a4f1601f309ef657d57e9c21fa8d571ef1",
    "d9870f21f0bc36fab479459feecb8331ddadebcf05249e958e735e31e21bf9fb23feef6b5f04bbe076bb1049a40e8b1795e3bad02beda8a1c36e592ce5e11e80"
    "751ccfbaf2dfc766073e8cc0f3dae8d3ec0027f29c3836b88b9a27b8eb1c42436e0cbe11cf4bde7eee2b3f063b30273c6276a04687d5482690ebf13b47a2a6ed",
    "9cb43b1db8077e3ded8027b6e87cd4911de8aa6c55611bc37fbb365e54b903cfa4e3949b09be2d229f19ecc11cf148d903259c0e14c28d6896a154f59c3e4eb4"
    "76f785159a17cc1a2f6210ed7b6df439d88307357618089e5c85253d4f28c03ab4078f5f01ebd073c31b9575c18375683cedafca3c4146f4d3a9fc3d8df80e73",
    "ddd9ea2fc7f78c3abb874b1e5f42e07b6d749b5d50199aa715aae9da7dcb39dbb3c7f63b938e477e4c76115d4f7eebad9f821d70bb1dd8cc5c848422279c1e72"
    "f93a75b8cf141a8d01dc2fb97476e00cd14fbcf381036cf3818f22f0bc36ba4def9be18e9b2564b7ae1f1f23f1ac744c7233e6db63d1212837993f6a831d70bb",
    "1d0845b72add5cf158e9e56bb5fcc505bd1b0f5e821d58c7f1ac97cf63f3ff9dcadfbbceb1a04bfa03be7170cf790827d6d97e42ef08ae7941f68e7e98745ce7"
    "5a8cd848343e7415847503f7db03b64d3179ad106c0bb9c17ed9bf4945c2a5f3155a3758157b809207a7f2f70ce23bccf8d0cb96bf7e61cfa87f775cef2d3adf",
    "74a49fd39cd855c774b7ce17f2483c2b1d935db8619bb9b04c509f1dff8606f6c1edf6e15c0846a8c8e0e894157abc16603331ff6e17e60b4b671fce10fdc42b"
    "7ff8ec00ec4bbb1dcfa4c3beb4fbe219655df0605f1a9ef6c11e4cafcd625d47c0670f66c93be5d44c97e72941d6060b9b175ccf88b788bcd309be2d22eff46f",
    "fe00d61396d61e383d0fbb97a62fb372e088d5d2fdbc1052caf471b4e8017bb06cf64046f4733ef945d1bd517515c1b6bef0b2edd963fb9d499f1637caf15dd5"
    "adf1a223249e958e315e3464d722ec01c48be688476a7e102fc4cbe5823f7ba21dd0d9f679e230dd0c5ec0beb435b707fb7ba36a62bff2b2d88365596f063b31",
    "bd360bd80932786027f0b47f8d78df291f4f11ed7b6df4478972d4e970565bb4c2d6378cc13c1ed24645f58d81bdcfcaac3eb44566b080f542dd3e5037f6e1eb"
    "88f69cf2ef53083caf8d6ed3cb46e43caaffb1c98a715aacf398ceb530fbf13e64bf0c4a576c8bd285884d8eaa483c2b7d68171c0bd214097a6c1ba6b0f0a14c",
    "322fe9f99fbe0eeb0c6eb70f83703327250b655fb3c0d58a31ad4c37f7cb2b74aef6acfe5e09d1bed7467fa2717d47bc38920a17c23237320d64e5efbfbfb498"
    "79c3bbeda25bedc0faf91357bff72fbf0ff38465b5034ed7174e82fc26dd6d659b1c779aa13a032dabc479cfead881bf47bcef948fe788f6bd363a3eff2e9928",
    "16bab22c291a5b9f32ce65ebf79d21fa3f2ffb00f30698374cfb1e98372c160fe60d78da8779c3f4da2c28bbf026a23da77cfb1d049ed746b7d985db8da56771"
    "f601fc8edbbfcf817c81bd98231e297be1577dfe021d2dd77c8d7c80f3490a9d6d7562602fccf6d6ea5c0c4f065b3eeb4710785e1b7d5a3eebd85e8ee88bdadf",
    "007ec6f4da2c1372a3fde797c00eb8dd0ed4e23b4a44f6f54b6a7d50634f2bc963f5b20cfbdc96ce0e90dd079ddd1b5557e3da93c396bf74cfbca1f17d0b9a6b"
    "ed02d93c25f39e056d11794a70dfce1cf148d905b999501bc1fe51cfb74be912198a7662253ebe3a76e11af1fe3ce2c4b8cfd566d81ecd578d23e416621ff64e",
    "f746f5d5b8be3ec5367fb8e7b97a23fba072976c55d62ce75e9fddb33ff642ca4e10ce931ec995c937c2fb28e1fe8539e211b31389ad13753b9bdd522eb763e7"
    "ad948f0f6c1f829d003b312cb7d809527914363bc154195ad53cf8d61f9e45f6c3a0e8c8fec97b5297f21ca55bd71f0c96c13ac36ae1911a7f9c5a0ea54e922d",
    "2e1f8c5742fc79b75361631eb00fcb6a1fce10fdc52a87d78fe0fc0c0f1ef981f333e68e372aeb8207e767e069ff1af1be5bed02d9f58737f646d5deb8be7e63"
    "d1eb0f705f0fdcd763c333cabae0c17d3d78daff36e27da77cf421daf7dae88f4683b8d015e4ae226ea80a634cefebac2055d97a93add6598d65344ed289528d",
    "e517b2efd9f3ea1e2e7d7ad77d986a4719867d16a6bfbf3b235e1c8967a5cf746e2adfe8eae2a0738aa4def6fcb0f40ae86db7ebedc001d5686d6e27ceb3943f"
    "a1e58e44b117dd5fa1750018bfd66295b75716bdfecba9fb92407322a5289265fd579eb13f1fb8a33f265de7fcc89a565bc626b845e493e2b84f67828da4f349",
    "dffa5904e2fdcb6a079cc675f874ba466df9a3c10b8e612855eeb52acd43cfead80118cfd36bb358e56f1b9b7fff9cedd973f33b83c2a9aa4c2b2aebd6f84c06"
    "8967a5cfe21f0c3934f4104c5e91cdf7b9fa0ef34bf0f39755bf3bf5f3837c3e7e21a5770efca57833c4442f93f9446185e233e0e75b0b2a5e33abbc7d1081e7",
    "b5d16d7e3e6bf7efcf66ecc75d7123a6455bf066b5ff65249e95fe44f2813e90e8b12bc01a2e00417dffcc3fbc02febcdbf5bd58ac1cd1be4afcd4dfeb75a972"
    "6fcb2f24b915ba2713f4bdb558e5ed21b6b8ce8711785e1b7deabaeb43337aefdebcfee21d78261dd37abec1b7b1cc4c7ec719a29f18f5fef7ffeddfc1cf5f56",
    "bdef348eb3d34d15368ffdd9b092f053623999df16f3db1ed0fbeba6f7df44b4e7944f9f41e0796d749bdea765991f14464a2c368eac27c41c4f33e3e3e59626"
    "beffce8cf8b53bf04d3a1ebb8066eb02d6ffa35f0dc2fc6059ed84d3f9412a79c8543ab9dd70251d50549fccf97aa1e40a9d3b07e37bfa773993c720c4ff1de2",
    "41fc1f379e51d6050fe2ff78da077d3ffdbb9cc963085bbce863083caf8d6e9b37745536a72b3949894a22d67dbea4d709c89e0361651b61bb5078b40df300b7"
    "db8541479077cbbb493e70ccb58ed848bcdfeb5556681e00e3797a6d16abfced60b303f73c4f547fe4c4664c520e72464615ac1b38919b49b6115f37f8f353b0",
    "03aeb7032d7fa8b9dbbca034b670dccd09c1662e17c9aed07a318ce7e9b55950eb0864f7ed36e5eec326ab1dc85d4aa46b3c5b5f98febfbe279ed9fe13dc5f86"
    "235d4867dc8685710b98478adf0a811d70bb1dc8668ed464beec0b7483c57e5894e5ce45360bf70bace97ce0f3d8ecc093dd63f9eeb8905be70164cf8fbe61d7",
    "02cef7b9fae73f847980ebf5fff68944277cfcf16120564ad7536ae052a65ab04e70d3de7aaf137c095b7ce8e3083caf8daeb3a5aab3a3aaeb345e92e4aad463"
    "95062f5d549916cbb417171fbabe279ed9fe99edd98e67d267ca4333c4ea16fe11dd57f0839f3f0bf6c1edf6413da4fad4fee5652ed9f705d2becde851786b93",
    "02fb00f66158f6566edf8189ffa47945ee8a37c2be8355c5837d0778da87f3df26e5ebb3d8e242bf8ec0f3dae8433f56d0388155ab2d96975965fc77b7c685e6"
    "763fdd84ff2fc9eac6bbf846fe9ed2bffac54f40bf2fab7e77eaf7d74f0774a0c6d0e5fd001dbe94a8a2705e9157685d6056bf9f46b4efb5d1e7309e1f309220",
    "48a231a3576ddf7586e8375679bc2a60f3fbef792f00a746ba1caf25c44c5760158ec1e6f7df754f3d2f3539dd775eee73266e3967caca36a2f1a0ef835d70bf"
    "5dc8f63ad17023dedb291e05060c2588bed8e92add37097661fa773993c7e2cada05d2f120b00bf3c233cabae0815d98adfdff07184b79fc",
    "" };

  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(data, 138784U, &nameCaptureInfo);
  return nameCaptureInfo;
}

/* End of code generation (_coder_sobel_info.c) */